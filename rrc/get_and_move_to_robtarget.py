import compas_rrc as rrc
from compas.geometry import Frame, Point, Vector

if __name__ == '__main__':

    # Create Ros Client
    ros = rrc.RosClient()
    ros.run()

    # Create ABB Client
    abb = rrc.AbbClient(ros, '/rob1')
    print('Connected.')

    # Set tool
    abb.send(rrc.SetTool('t_FoC2026_Loop'))

    # Set work object
    abb.send(rrc.SetWorkObject('ob_FoC2026_Tile_1'))
    #external_axes =  [22350.0, -11000, -2250, 0.0, 0.0, 0.0]
    
    # Get frame and external axes 
    #frame, external_axes = abb.send_and_wait(rrc.GetRobtarget())

    # Print received values
    #print(frame, external_axes)

    # Change a value of the frame 
    #frame.point[0] -= 50
    # Frame(point=Point(x=-330, y=307, z=187), xaxis=Vector(x=0.45, y=0.9, z=-0.0), yaxis=Vector(x=0.9, y=-0.45, z=-0.0))
    # Frame(point=Point(x=965.9609375, y=-18.175090789794922, z=186.0376434326172), xaxis=Vector(x=1.0, y=0.0, z=0.0), yaxis=Vector(x=0.0, y=-1.0, z=0.0))
    
    frame = Frame(Point(0.0, 0.0, 200.0), Vector(-1.0, 0.0, 0.0), Vector(0.0, 1.0, 0.0))

    # frame = Frame.from_points(Point(0,0,200), Vector(1,0,0), Vector(0,-1,0))
    #print("New frame: ", frame)

    # Set speed [mm/s]
    speed = 50

    # Move robot the new pos
    #done = abb.send_and_wait(rrc.MoveToRobtarget(frame, external_axes, speed, rrc.Zone.FINE))
    done = abb.send_and_wait(rrc.MoveToFrame(frame, speed, rrc.Zone.FINE, rrc.Motion.LINEAR))

    # Print feedback 
    print('Feedback = ', done)

    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()
