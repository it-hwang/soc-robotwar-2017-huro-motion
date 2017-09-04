'******** HURO-C ��ֹ� ���α׷� ********
' 0�� ����: ���� �ٸ����̵�
' 1�� ����: ���� �ٸ����̵�(����)
' 2�� ����: ���� �ٸ����̵�(������)


DIM I AS INTEGER
DIM b AS INTEGER
DIM ���̷�ONOFF AS INTEGER

'******** �ʱ�ȭ ���� ********
DIR G6A, 0, 0, 1
SPEED 3
GOSUB MOTOR_ON
GOSUB MOTOR_READ

GOTO MAIN	'�ݺ� ���� ��ƾ���� ����

'************************************************
MOTOR_READ:
    FOR I = 1 TO 15
        b=MOTORIN(2)
    NEXT I
    RETURN
    '************************************************

MOTOR_ON:
    MOTOR G6A				'����0~7�� �׷��� ����
    MOTOR G6B				'����8~15�� �׷��� ����
    MOTOR G6C				'����16~23�� �׷��� ����
    MOTOR G6D				'����24~31�� �׷��� ����
    RETURN

MOTOR_OFF:
    MOTOROFF G6A				'����0~7�� �׷��� ����
    MOTOROFF G6B				'����8~15�� �׷��� ����
    MOTOROFF G6C				'����16~23�� �׷��� ����
    MOTOROFF G6D				'����24~31�� �׷��� ����
    RETURN
    '************************************************


    '************************************************
All_motor_Reset:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1, , ,1
    MOTORMODE G6C,1,1,1, , 1
    RETURN
    '************************************************
All_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2, , ,2
    MOTORMODE G6C,2,2,2, , 2
    RETURN
    '************************************************
All_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3, ,3 ,
    RETURN
    '************************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1
    RETURN
    '************************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2
    RETURN
    '************************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3
    MOTORMODE G6C,3,3,3
    RETURN
    '************************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '************************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '************************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '************************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN
    '************************************************
Leg_motor_mode5:
    MOTORMODE G6A,2,3,3,3,2
    MOTORMODE G6D,2,3,3,3,2
    RETURN
    '************************************************


    '***********************************************
    '**** ���̷ΰ��� ���� ****
    '***********************************************

���̷�INIT:
    GYRODIR G6A, 0, 0, 0, 0,1
    GYRODIR G6D, 1, 0, 0, 0,0

    RETURN
    '***********************************************
���̷�MAX:
    GYROSENSE G6A,255 , 255,255,255
    GYROSENSE G6D,255 , 255,255,255

    RETURN
    '***********************************************
���̷�MID:
    GYROSENSE G6A, 255, 100,100,100
    GYROSENSE G6D, 255, 100,100,100

    RETURN
    '***********************************************
���̷�MIN:
    GYROSENSE G6A, 50, 50,50,50
    GYROSENSE G6D, 50, 50,50,50

    RETURN
    '***********************************************
���̷�ST:
    GYROSENSE G6A,100,30,30,30,
    GYROSENSE G6D,100,30,30,30 ,

    RETURN
    '***********************************************
���̷�ON:
    GYROSET G6A, 2, 1, 1, 1,
    GYROSET G6D, 2, 1, 1, 1,

    ���̷�ONOFF = 1
    RETURN
    '***********************************************
���̷�OFF:
    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0

    ���̷�ONOFF = 0
    RETURN
    '************************************************


MAIN:
	MOVE G6A, 10, 10, 10
	DELAY 10000
	MOVE G6A, 100, 100, 100
	DELAY 10000
	GOTO MAIN
