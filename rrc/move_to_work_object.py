import compas_rrc as rrc

from compas.geometry import Frame 
from compas.geometry import Point
from compas.geometry import Vector

SAFE_ROB_JOINT_POS = [48.59, 22.56, 31.66, 0.0, 30.0, 0.0]
CALIBRATION_ROB_JOINT_POS = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
SAFE_EAXIS_POS = [0.00]

# XAXIS=Vector(x=-0.6229742141603843, y=-0.7772070432884672, z=-0.0886134321310836) 
# YAXIS=Vector(x=-0.7796904711540982, y=0.6260876773011926, z=-0.009848325903332858)

XAXIS=Vector(-1.000, 0.000, 0.000)
YAXIS=Vector(0.000, 1.000, 0.000)

# Frame(
#     point=Point(x=-295.2491455078125, y=-139.1357421875, z=432.6177978515625), 
#     xaxis=Vector(x=-0.6229742141603843, y=-0.7772070432884672, z=-0.0886134321310836), 
#     yaxis=Vector(x=-0.7796904711540982, y=0.6260876773011926, z=-0.009848325903332858)
#     ) 



if __name__ == '__main__':

    # Create Ros Client
    ros = rrc.RosClient()
    ros.run()

    # Create ABB Client
    abb = rrc.AbbClient(ros, '/rob1')
    print('Connected.')

    # Set tool
    abb.send(rrc.SetTool('t_clay'))

    # Set work object
    abb.send(rrc.SetWorkObject('w_pallet_sam_corner'))

    # Move robot the new pos
    # abb.send_and_wait(rrc.MoveToJoints(SAFE_ROB_JOINT_POS, SAFE_EAXIS_POS, 250, rrc.Zone.FINE))

    
    # Get frame and external axes 
    # frame, external_axes = abb.send_and_wait(rrc.GetRobtarget())

    # Print received values
    # print(frame, external_axes)
    # point=Point(x=-295.2491455078125, y=-139.1357421875, z=432.6177978515625), 

    frame = Frame(Point(100, 100, 50), XAXIS, YAXIS)
    exaternal_axes = [50.0]

    done = abb.send_and_wait(rrc.MoveToRobtarget(frame, exaternal_axes, 100, rrc.Zone.FINE))

    

    # Print feedback 
    #print('Feedback = ', done)

    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()
