import compas_rrc as rrc

CALIBRATION_ROB_JOINT_POS = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
CALIBRATION_EAXIS_POS = [0.0]

if __name__ == '__main__':

    # Create Ros Client
    ros = rrc.RosClient()
    ros.run()

    # Create ABB Client
    abb = rrc.AbbClient(ros, '/rob1')
    print('Connected.')

    done = abb.send_and_wait(rrc.MoveToJoints(CALIBRATION_ROB_JOINT_POS, CALIBRATION_EAXIS_POS, 250, rrc.Zone.FINE))

    # Print feedback 
    print('Feedback = ', done)

    # End of Code
    print('Finished')

    # Close client
    ros.close()
    ros.terminate()