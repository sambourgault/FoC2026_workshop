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
    carving_tool = 't_RRC_Tool_Z'
    #carving_signal = 'do_Z' # what are signals?

    # Define speed 
    speed = 100
    speed_carving = 20 # Unit [mm/s]

    # Set work object
    done = abb.send_and_wait(rrc.SetWorkObject('wobj0')) #wobj_carving is only in robot studio not controller?
    # should i print feedback everywhere?

    # Set tool
    abb.send(rrc.SetTool(carving_tool))

    # Load JSON next to this script, independent of current working directory.
    motion_file = PATHS_FOLDER / "motion_000_scaled.json"
    data = json_load(str(motion_file))
    recorded_frames = data["samples"]

    # JSON stores frame positions in meters; robot motion expects millimeters.
    recorded_wo_frame_m = data["workobject"]["frame"]
    recorded_wo_frame_mm = frame_m_to_mm(recorded_wo_frame_m)
    
    #recorded_wo_frame_mm_flipped = recorded_wo_frame_mm.flipped()
    print("Recorded workobject origin [mm]:", recorded_wo_frame_mm.point)
    print("Recorded workobject normal [mm]:", recorded_wo_frame_mm.normal)

    # transform into new workobject frame
    new_wo_frame = Frame(Point(750.00, 500.00, 500.00), Vector(1, 0, 0), Vector(0, 1, 0))
    #rotate to fit the workobject
    new_wo_frame.rotate(-pi/2, axis=new_wo_frame.zaxis, point=new_wo_frame.point)

    transform = Transformation.from_frame_to_frame(recorded_wo_frame_mm, new_wo_frame)

    # first recorded TCP frame
    first_key = sorted(recorded_frames.keys(), key=int)[0]
    first_sample_frame_m = recorded_frames[first_key]["frame"]
    first_sample_frame_mm = frame_m_to_mm(first_sample_frame_m)
    new_first_sample_frame = first_sample_frame_mm.transformed(transform)

    #move above the first frame
    above_first_frame = Frame(new_first_sample_frame.point + Vector(0, 0, 50), new_first_sample_frame.xaxis, new_first_sample_frame.yaxis)
    done = abb.send_and_wait(rrc.MoveToFrame(above_first_frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))
    print("Moved above first recorded TCP origin [mm]:", above_first_frame.point)

    # then move to first position
    done = abb.send_and_wait(rrc.MoveToFrame(new_first_sample_frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))
    print("Moved to first recorded TCP origin [mm]:", new_first_sample_frame.point)

    last_frame_mm = None
    #go through all the frames
    for key in sorted(recorded_frames.keys(), key=int):
        sample_frame_m = recorded_frames[key]["frame"]
        sample_frame_mm = frame_m_to_mm(sample_frame_m)
        new_sample_frame = sample_frame_mm.transformed(transform)
        last_frame_mm = new_sample_frame

        done = abb.send_and_wait(rrc.MoveToFrame(new_sample_frame, speed_carving, rrc.Zone.FINE, rrc.Motion.LINEAR))
        #print(f"Moved to frame {key} with feedback: {done}")
    
    #move above the last frame
    above_last_frame = Frame(last_frame_mm.point + Vector(0, 0, 50), last_frame_mm.xaxis, last_frame_mm.yaxis)
    done = abb.send_and_wait(rrc.MoveToFrame(above_last_frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))
    print("Moved above last recorded TCP origin [mm]:", above_last_frame.point)

    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()

