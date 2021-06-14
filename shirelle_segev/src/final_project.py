#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from manipulator_h_base_module_msgs.msg import KinematicsPose
import math

def final_project():
    rospy.init_node('shirelle_and_segev_final_project', anonymous=True)
    print "Hello proffesor, we have been waiting for you"
    rate = rospy.Rate(0.2)
    # for x in "Hello proffesor, we have been waiting for you":
    #     print(x, end =" ")
    #     rate.sleep()
    try:
        initialization()
    except rospy.ROSInterruptException:
        pass
    rate.sleep()
    try:
        go_to_initial_pose()
    except rospy.ROSInterruptException:
        pass
    rate.sleep()
    try:
        do_as_I_command_almost()
    except rospy.ROSInterruptException:
        pass
    rospy.spin()

def initialization():
    print "Please wait while the robot Initializing"
    pub = rospy.Publisher("robotis/base/set_mode_msg", String, queue_size=10)
    rate = rospy.Rate(10)
    initial_str = "set_mode"
    for x in range(3):
        pub.publish(initial_str)
        rate.sleep()

def go_to_initial_pose():
    print "Please wait while the robot moves to its starting point"
    pub = rospy.Publisher("robotis/base/ini_pose_msg", String, queue_size=10)
    rate = rospy.Rate(10)
    initial_pose_str = "ini_pose"
    for x in range(2):
        pub.publish(initial_pose_str)
        rate.sleep()

def do_as_I_command_almost():
    print "The robot will go wherever u tell him to go (almost...)"
    print "Let's try it now"
    pub = rospy.Publisher("robotis/base/kinematics_pose_msg", KinematicsPose, queue_size=10)
    rate = rospy.Rate(10)
    end_point = KinematicsPose()
    while not rospy.is_shutdown():
        end_point.pose.position.x = input("Please enter x coordinate: ")
        end_point.pose.position.y = input("Please enter y coordinate: ")
        end_point.pose.position.z = input("Please enter z coordinate: ")
        roll = input("Please enter roll angle: ")
        pitch = input("Please enter pitch angle: ")
        yaw = input("Please enter yaw angle: ")
        cr = math.cos(roll*math.pi/360)
        cp = math.cos(pitch*math.pi/360)
        cy = math.cos(yaw*math.pi/360)
        sr = math.sin(roll*math.pi/360)
        sp = math.sin(pitch*math.pi/360)
        sy = math.sin(yaw*math.pi/360)
        end_point.pose.orientation.w = cr * cp * cy + sr * sp * sy
        end_point.pose.orientation.x = sr * cp * cy - cr * sp * sy
        end_point.pose.orientation.y = cr * sp * cy + sr * cp * sy
        end_point.pose.orientation.z = cr * cp * sy - sr * sp * cy
        for x in range(2):
            pub.publish(end_point)
            rate.sleep()


if __name__ == '__main__':
    final_project()