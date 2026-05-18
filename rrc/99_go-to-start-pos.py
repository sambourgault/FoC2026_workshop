import compas_rrc as rrc

if __name__ == '__main__':

    # Create Ros Client
    ros = rrc.RosClient()
    ros.run()

    # Create ABB Client
    abb = rrc.AbbClient(ros, '/rob1')
    print('Connected.')

    # Set start values
    robot_joints, external_axes =[25, -50, 45, 180, 85, -30],  [22350.0, -11000, -2250, 0.0, 0.0, 0.0]

    # Frame(point=Point(x=23409.236328125, y=9074.7197265625, z=389.19171142578125), xaxis=Vector(x=-0.9878888368650063, y=-0.15504468213824138, z=0.0060656852998360825), yaxis=Vector(x=-0.15472290885501389, y=0.9872752271436562, z=0.036721211089572735)) ExternalAxes([22350.0, -10839.4, -2016.45, 0.0, 0.0, 0.0])

    # Move robot to start position
    done = abb.send_and_wait(rrc.MoveToJoints(robot_joints, external_axes, 250, rrc.Zone.FINE))

    # Print feedback 
    print('Feedback = ', done)

    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()
