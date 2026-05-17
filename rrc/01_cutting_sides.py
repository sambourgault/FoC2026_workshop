from math import pi
import compas_rrc as rrc
from compas.geometry import Frame 
from compas.geometry import Point
from compas.geometry import Vector
from compas.geometry import Transformation, Rotation
from compas.data import json_load
from pathlib import Path


def frame_m_to_mm(frame_m):
    """Convert only frame origin from meters to millimeters."""
    return Frame(
        Point(frame_m.point[0] * 1000.0, frame_m.point[1] * 1000.0, frame_m.point[2] * 1000.0),
        Vector(frame_m.xaxis[0], frame_m.xaxis[1], frame_m.xaxis[2]),
        Vector(frame_m.yaxis[0], frame_m.yaxis[1], frame_m.yaxis[2]),
    )

PATHS_FOLDER = Path(__file__).with_name("sam_paths_may_16")

if __name__ == '__main__':
    # Create Ros Client
    ros = rrc.RosClient()
    ros.run()

    # Create ABB Client
    abb = rrc.AbbClient(ros, '/rob1')
    print('Connected.')

    # Print text on FlexPenant
    done = abb.send_and_wait(rrc.PrintText('Welcome to PhysicalSibling'))
    # Print feedback 
    print('Feedback = ', done)

    # Select tool and print output
    cutting_tool = 't_RRC_Tool_Z'
    #cutting_signal = 'do_Z' # what are signals?

    # Define speed 
    speed = 100
    speed_cutting = 20 # Unit [mm/s]

    # Set work object
    done = abb.send_and_wait(rrc.SetWorkObject('wobj0')) #wobj_cutting is only in robot studio not controller?
    # should i print feedback everywhere?

    # Set tool
    abb.send(rrc.SetTool(cutting_tool))

    # cutting pass for one tile
    tileNumber = 0
    offsetX = tileNumber*(280 + 20) # add some offset to make sure we cut the whole tile
    depthOfCut = 8 # depth of cut in mm

    new_wo_frame = Frame(Point(750.00 + offsetX, 500.00, 500.00 - depthOfCut), Vector(1, 0, 0), Vector(0, 1, 0))
    new_wo_frame.rotate(-pi/2, axis=new_wo_frame.zaxis, point=new_wo_frame.point)
    new_wo_frame.rotate(pi, axis=new_wo_frame.xaxis, point=new_wo_frame.point)

    frame0 = new_wo_frame.copy()
    frame1 = frame0.copy()
    frame1.point += Vector(600, 0, 0)
    frame2 = frame1.copy()
    frame2.point -= Vector(0, 280, 0)
    frame3 = frame2.copy()
    frame3.point -= Vector(600, 0, 0)
    frame4 = frame3.copy()
    frame4.point += Vector(0, 280, 0)

    frames = [frame0, frame1, frame2, frame3, frame4]

    # go above first frame
    above_first_frame = Frame(frame0.point + Vector(0, 0, 50), frame0.xaxis, frame0.yaxis)
    done = abb.send_and_wait(rrc.MoveToFrame(above_first_frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))
    print("Moved above first frame [mm]:", above_first_frame.point)

    for frame in frames:
        done = abb.send_and_wait(rrc.MoveToFrame(frame, speed_cutting, rrc.Zone.FINE, rrc.Motion.LINEAR))
        print(f"Moved to frame with origin {frame.point} with feedback: {done}")
    
    #go above the last frame
    above_last_frame = Frame(frame4.point + Vector(0, 0, 50), frame4.xaxis, frame4.yaxis)
    done = abb.send_and_wait(rrc.MoveToFrame(above_last_frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))
    print("Moved above last frame [mm]:", above_last_frame.point)
    
    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()

