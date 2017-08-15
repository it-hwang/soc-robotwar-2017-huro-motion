'******** 2�� ����κ� �ʱ� ���� ���α׷� ********

CONST DEFAULT_SPEED = 5

DIM I AS BYTE
DIM A AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM RECEIVED_DATA AS BYTE
DIM SERVO_ID AS BYTE
DIM SERVO_VALUE AS BYTE
DIM SERVO_SPEED AS BYTE
DIM MODE AS BYTE
DIM TEMP AS BYTE

DIM Ƚ�� AS BYTE
DIM ���� AS BYTE
DIM ������� AS BYTE

DIM ���̷�ONOFF AS BYTE

DIM ����Ʈ�ȱ�Ƚ�� AS BYTE
DIM ����Ʈ�ȱ����� AS BYTE

PTP SETON 				'�����׷캰 ���������� ����
PTP ALLON				'��ü���� ������ ���� ����

DIR G6A,1,0,0,1,0,0		'����0~5�� �׷��� ����
DIR G6B,1,1,1,1,1,1		'����6~11�� �׷��� ����
DIR G6C,0,0,0,0,0,0		'����12~17�� �׷��� ����
DIR G6D,0,1,1,0,1,0		'����18~23�� �׷��� ����

'***** ���� ����*******************************************
'�ʱ� �ȱ� ����
����Ʈ�ȱ�����=0
������� = 0

SERVO_SPEED = DEFAULT_SPEED


'****�ʱ���ġ �ǵ��*****************************

'GETMOTORSET G6A,1,1,1,1,1,0
'GETMOTORSET G6B,1,1,1,0,0,0
'GETMOTORSET G6C,1,1,1,0,0,0
'GETMOTORSET G6D,1,1,1,1,1,0


SPEED 5
GOSUB MOTOR_ON
GOSUB MOTOR_READ

GOSUB ���忬���ڼ�
GOSUB �Ӹ�����

GOSUB ���̷�INIT
GOSUB ���̷�MID
GOSUB ���̷�ON

GOTO MAIN	'�ø��� ���� ��ƾ���� ����

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



    '******************************************
    '******************************************	
�ڼ�100:
    MOVE G6A,100,  100,  100, 100, 100, 100
    MOVE G6D,100,  100,  100, 100, 100, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT
    RETURN




























    '**********************************************
    ' �Ӹ�
    '**********************************************
�Ӹ�����:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    , 100	'����
    WAIT
    RETURN

�Ӹ��ٴ�:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    , 10	'����
    WAIT
    RETURN

�Ӹ��߾Ӽ�:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  25	'����
    WAIT
    RETURN

�Ӹ��߾Ӽ�2:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  45	'����
    WAIT
    RETURN

�Ӹ����ʼ�:
    MOVE G6B,   ,    ,    ,    ,    ,  21	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  50	'����
    WAIT
    RETURN

�Ӹ������ʼ�:
    MOVE G6B,   ,    ,    ,    ,    , 179	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  50	'����
    WAIT
    RETURN

�Ӹ����ʼ�2:
    MOVE G6B,   ,    ,    ,    ,    ,  10	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  45	'����
    WAIT
    RETURN

�Ӹ������ʼ�2:
    MOVE G6B,   ,    ,    ,    ,    , 190	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  45	'����
    WAIT
    RETURN

�Ӹ���ֹ�_����:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  70	'����
    WAIT
    RETURN

�Ӹ���ֹ�_����:
    MOVE G6B,   ,    ,    ,    ,    ,  60	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  70	'����
    WAIT
    RETURN

�Ӹ���ֹ�_������:
    MOVE G6B,   ,    ,    ,    ,    , 140	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  70	'����
    WAIT
    RETURN

�Ӹ���ֹ�_�ϴ�����:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  50	'����
    WAIT
    RETURN

�Ӹ���ֹ�_����������:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  40	'����
    WAIT
    RETURN

�Ӹ���ֹ�_�ϴܿ���:
    MOVE G6B,   ,    ,    ,    ,    ,  60	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  50	'����
    WAIT
    RETURN

�Ӹ���ֹ�_�ϴܿ�����:
    MOVE G6B,   ,    ,    ,    ,    , 140	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  50	'����
    WAIT
    RETURN

�Ӹ���ܼ�:
    MOVE G6B,   ,    ,    ,    ,    , 100	'�¿�
    MOVE G6C,   ,    ,    ,    ,    ,  20	'����
    WAIT
    RETURN



    MOVE G6A,100,  92, 125, 100, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    , 100
    MOVE G6C,100,  30,  80, 100,    , 100
    WAIT

    '**********************************************
    ' ���� �ڼ�
    '**********************************************
�⺻�ڼ�:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    MODE = 0
    RETURN

�ȹ����⺻�ڼ�:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  80,  80, 100,    ,
    MOVE G6C,100,  80,  80, 100,    ,
    WAIT
    MODE = 0
    RETURN

���忬���ڼ�:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C, 70,  30,  80, 100,    ,
    WAIT
    MODE = 0
    RETURN

�����ڼ�:
    MOVE G6A, 100, 170,  21, 123, 100,
    MOVE G6D, 100, 170,  21, 123, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,100
    WAIT
    MODE = 0
    RETURN



�⺻�ڼ�_�߽ɿ���_��:
    MOVE G6A,106,  95, 120, 100, 94,
    MOVE G6D, 94,  92, 125, 100, 106,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�⺻�ڼ�_�߽ɿ�����_��:
    MOVE G6A, 94,  92, 125, 100, 106,
    MOVE G6D,106,  95, 120, 100, 94,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�����ڼ�_��:
    MOVE G6A, 97,  92, 125, 100, 103,
    MOVE G6D, 97,  92, 125, 100, 103,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�����ڼ�_��_�߽ɿ���_��:
    MOVE G6A,102,  95, 120, 100,  97,
    MOVE G6D, 91,  92, 125, 100, 109,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�����ڼ�_��_�߽ɿ�����_��:
    MOVE G6A, 91,  92, 125, 100, 109,
    MOVE G6D,102,  95, 120, 100,  97,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�����ڼ�_��:
    MOVE G6A, 95,  92, 125, 100, 105,
    MOVE G6D, 95,  92, 125, 100, 105,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�����ڼ�_��:
    MOVE G6A, 90,  92, 125, 100, 110,
    MOVE G6D, 90,  92, 125, 100, 110,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

�⺻�ڼ�_�޹߶���:
    MOVE G6A,  78,  71, 155,  88, 114,
    MOVE G6D, 116,  92, 125, 100,  93,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

�⺻�ڼ�_�����߶���:
    MOVE G6A, 116,  92, 125, 100,  93,
    MOVE G6D,  78,  71, 155,  88, 114,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

�޹ߵ��_��:
    MOVE G6A, 95,  92, 125,  100, 100,
    MOVE G6D,114,  92, 125,  100, 100,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

�޹ߵ��_��:
    MOVE G6A, 90,  90, 125,  100, 90,
    MOVE G6D,111,  90, 125,  100, 120,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  50,  80,  100,    ,
    WAIT
    RETURN

�����ߵ��_��:
    MOVE G6A,114,  92, 125,  100, 100,
    MOVE G6D, 95,  92, 125,  100, 100,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

�����ߵ��_��:
    MOVE G6A,111,  90, 125,  100, 120,
    MOVE G6D, 90,  90, 125,  100, 90,
    MOVE G6B,100,  50,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

�޹ߵ��2_��:
    MOVE G6A, 86,  92, 125,  100, 114,
    MOVE G6D,116,  92, 125,  100,  93,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

�޹ߵ��2_��:
    MOVE G6A, 86,  103, 105,  110, 114,
    MOVE G6D,116,  92, 125,  100,  93,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

�����ߵ��2_��:
    MOVE G6A,116,  92, 125,  100,  93,
    MOVE G6D, 86,  92, 125,  100, 114,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

�����ߵ��2_��:
    MOVE G6A,116,  92, 125,  100,  93,
    MOVE G6D, 86,  103, 105,  110, 114,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

�޹߳��б�_��:
    MOVE G6A,  86,  61, 141, 116, 114,
    MOVE G6D, 116,  92, 125, 100,  93,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

�����߳��б�_��:
    MOVE G6A, 116,  92, 125, 100,  93,
    MOVE G6D,  86,  61, 141, 116, 114,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

�޹߻���_��:
    MOVE G6A,  93,  58, 141, 120, 109,
    MOVE G6D, 108,  96, 119, 108,  89,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

�����߻���_��:
    MOVE G6A, 108,  96, 119, 108,  89,
    MOVE G6D,  93,  58, 141, 120, 109,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

������Ȯ���ڼ�:
    MOVE G6A, 100,  92, 125, 100, 100
    MOVE G6D, 100,  92, 125, 100, 100
    MOVE G6B,  10,  30,  10, 100,    ,
    MOVE G6C,  10,  30,  10, 100,    ,
    WAIT
    RETURN


    '**********************************************
    ' �����̴� �ڼ�
    '**********************************************
���ʿ�����_��:
    SPEED 10
    MOVE G6A, 90, 106,  99, 112, 105, 	
    MOVE G6D,100,  92, 125, 100, 107, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6A, 102,  92, 126, 100, 100,
    MOVE G6D,83,  94, 119,  103, 115,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    RETURN

���ʿ�����_��2:
    SPEED 10
    MOVE G6A, 97, 106,  99, 112, 100, 	
    MOVE G6D,100,  92, 125, 100, 107, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6A, 102,  92, 126, 100, 100,
    MOVE G6D,88,  94, 119,  103, 110,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    RETURN

�����ʿ�����_��:
    SPEED 10
    MOVE G6A,100,  92, 125, 100, 107, 	
    MOVE G6D, 90, 106,  99, 112, 105, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6A,83,  94, 119,  103, 115,
    MOVE G6D, 102,  92, 126, 100, 100,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    RETURN

�����ʿ�����_��2:
    SPEED 10
    MOVE G6A,100,  92, 125, 100, 107, 	
    MOVE G6D, 97, 106,  99, 112, 100, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6A,88,  94, 119,  103, 110,
    MOVE G6D, 102,  92, 126, 100, 100,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    RETURN

������ȸ��_��:
    SPEED 5
    MOVE G6A,96,  82, 125,  110, 105
    MOVE G6D,96, 102, 125,  90, 105
    'MOVE G6B, 90
    'MOVE G6C, 110
    WAIT

    SPEED 9
    MOVE G6A,93,  82, 125,  110, 103
    MOVE G6D,93, 102, 125,   90, 103
    WAIT

    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    'MOVE G6B,100,  30,  80
    'MOVE G6C,100,  30,  80
    WAIT

    RETURN

������ȸ��_��2:
    GOSUB ���̷�OFF

    GOSUB Leg_motor_mode1
    SPEED 10
    MOVE G6D,108,  90, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6D,100,  112, 125, 80, 100
    MOVE G6A,100,  72, 125, 120, 100
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 3
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    GOSUB ���̷�ON
    RETURN

������ȸ��_��3:
    GOSUB ���̷�OFF

    GOSUB Leg_motor_mode1
    SPEED 10
    MOVE G6D,108,  90, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6D,100,  112, 125, 80, 100
    MOVE G6A,100,  72, 125, 120, 100
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 1
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    GOSUB ���̷�ON
    RETURN

������ȸ��_��:
    GOSUB Leg_motor_mode2
    SPEED 3
    MOVE G6D, 111,  92, 125, 100,  89,
    MOVE G6A,  89,  92, 125, 100, 111,
    WAIT

    SPEED 8
    MOVE G6D, 115,  92, 125, 100,  89,
    MOVE G6A,  89, 105,  86, 124, 118,
    WAIT

    SPEED 8
    MOVE G6D, 115,  92, 125, 100,  89,
    MOVE G6A,  89,  41, 143, 135, 118,
    WAIT

    SPEED 5
    MOVE G6D, 108, 110, 108, 102,  86,
    MOVE G6A,  93,  45, 141, 135, 112,
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    DELAY 100
    RETURN

����ȸ��_��:
    SPEED 5
    MOVE G6A,96, 102, 125,  90, 105
    MOVE G6D,96,  82, 125,  110, 105
    'MOVE G6B, 110
    'MOVE G6C, 90
    WAIT

    SPEED 9
    MOVE G6A,93, 102, 125,   90, 103
    MOVE G6D,93,  82, 125,  110, 103
    WAIT

    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    'MOVE G6B,100,  30,  80
    'MOVE G6C,100,  30,  80
    WAIT

    RETURN

����ȸ��_��2:
    GOSUB ���̷�OFF

    GOSUB Leg_motor_mode1
    SPEED 10
    MOVE G6A,108,  90, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  112, 125, 80, 100
    MOVE G6D,100,  72, 125, 120, 100
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    GOSUB ���̷�ON
    RETURN

����ȸ��_��3:
    GOSUB ���̷�OFF

    GOSUB Leg_motor_mode1
    SPEED 10
    MOVE G6A,108,  90, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  112, 125, 80, 100
    MOVE G6D,100,  72, 125, 120, 100
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 1
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    GOSUB ���̷�ON
    RETURN

����ȸ��_��:
    GOSUB Leg_motor_mode2
    SPEED 3
    MOVE G6A, 111,  92, 125, 100,  89,
    MOVE G6D,  89,  92, 125, 100, 111,
    WAIT

    SPEED 8
    MOVE G6A, 115,  92, 125, 100,  89,
    MOVE G6D,  89, 105,  86, 124, 118,
    WAIT

    SPEED 8
    MOVE G6A, 115,  92, 125, 100,  89,
    MOVE G6D,  89,  41, 143, 135, 118,
    WAIT

    SPEED 5
    MOVE G6A, 108, 110, 108, 102,  86,
    MOVE G6D,  93,  45, 141, 135, 112,
    WAIT

    SPEED 6
    GOSUB �⺻�ڼ�
    DELAY 100
    RETURN


�Űȱ�����������Ʈ:
	
	GOSUB �⺻�ڼ�
	
	RETURN
	
    '***********************************************
    ' [SMART MOTION V.1 - KALSRAN] 2017-08-11 �ʱ�����
    '***********************************************
    ' 1) �������� �Է¹޴´�.
    ' 2) ���� ���������� ��� 2�����̿���.

����Ʈ�ȱ�_1:

    IF ����Ʈ�ȱ�����=0 THEN
        '�⺻�ڼ����� ������ ���
        GOSUB �ȱ�_����_����

        FOR I = 1 TO ����Ʈ�ȱ�Ƚ��
            GOSUB �ȱ�_�ݺ�_����
            GOSUB �ȱ�_�ݺ�_������
        NEXT I
    ENDIF

    IF ����Ʈ�ȱ�����=1 THEN
        '���� �հ������� ������ ���
        FOR I = 1 TO ����Ʈ�ȱ�Ƚ��
            GOSUB �ȱ�_�ݺ�_������
            GOSUB �ȱ�_�ݺ�_����			
        NEXT I
    ENDIF

    IF ����Ʈ�ȱ�����=2 THEN
        '������ �հ������� ������ ���
        FOR I = 1 TO ����Ʈ�ȱ�Ƚ��
            GOSUB �ȱ�_�ݺ�_����
            GOSUB �ȱ�_�ݺ�_������
        NEXT I
    ENDIF

    RETURN

����Ʈ�ȱ⿡���⺻����:
    IF ����Ʈ�ȱ�����=2 THEN
        GOSUB �ȱ�_��_������
    ENDIF

    IF ����Ʈ�ȱ�����=1 THEN
        GOSUB �ȱ�_��_����
    ENDIF

    RETURN

�ȱ�_����_����:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,  96, 87, 132, 98, 110
    MOVE G6D, 104, 92, 126, 100, 94
    MOVE G6B, 100, 30
    MOVE G6C, 100, 30
    WAIT

    SPEED 12

    MOVE G6A,  92, 116,  95, 109, 114
    MOVE G6D, 112,  94, 126,  97,  94
    MOVE G6B,  90,  30
    MOVE G6C, 110,  40
    WAIT
    RETURN

�ȱ�_�ݺ�_����:

    SPEED 12

    MOVE G6A,  92, 116,  95, 109, 114
    MOVE G6D, 112,  94, 126,  97,  94
    MOVE G6B,  90,  30
    MOVE G6C, 110,  40
    WAIT

    SPEED 10
    '�����߻�������
    MOVE G6A,  87,  60, 143, 117, 114
    MOVE G6D, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A, 112, 92, 124, 104, 93
    MOVE G6D, 87, 109, 135, 75, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A, 113,  93, 126,  97,  94
    MOVE G6D,  92, 116,  85, 114, 114
    MOVE G6B, 110
    MOVE G6C,  90
    WAIT

    ����Ʈ�ȱ�����= 2

    RETURN

�ȱ�_�ݺ�_������:

    SPEED 10
    '�����߻�������
    MOVE G6D,  87,  60, 143, 117, 114
    MOVE G6A, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D, 112,  92, 124, 104,  93
    MOVE G6A,  87, 109, 135,  75, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D, 113,  93, 126,  97,  94
    MOVE G6A,  92, 116,  85, 114, 114
    MOVE G6C, 110
    MOVE G6B,  90
    WAIT

    ����Ʈ�ȱ�����= 1

    RETURN

�ȱ�_��_����:

    SPEED 10
    '�޹ߵ��10
    MOVE G6A, 92, 116, 85, 114, 114
    MOVE G6D, 113, 93, 126, 97, 94
    MOVE G6B, 90,  30
    MOVE G6C, 110, 40
    WAIT

    SPEED 6
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 106, 100, 109, 114
    WAIT

    SPEED 6
    'MOVE G6A,  86,  88, 134,  93, 114,
    MOVE G6A,  86,  85, 134,  96, 114,
    MOVE G6D, 113,  93, 126, 97,  94,
    WAIT

    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,    ,  30
    MOVE G6C,    ,  30
    WAIT

    SPEED 5

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB �⺻�ڼ�

    ����Ʈ�ȱ�����= 0

    RETURN

�ȱ�_��_������:
    GOSUB �⺻�ڼ�

    ����Ʈ�ȱ�����= 0

    RETURN


��������_����_����:
    GOSUB Leg_motor_mode3
    SPEED 14
    '�����ʱ���
    MOVE G6A,  96, 87, 132, 98, 110
    MOVE G6D, 104, 92, 126, 100, 94
    MOVE G6B, 100, 30
    MOVE G6C, 100, 30
    WAIT

    SPEED 12'����ӵ�
    '�޹ߵ��
    MOVE G6A,  92, 116,  95, 109, 114
    MOVE G6D, 112,  94, 126,  97,  94
    MOVE G6B,  90,  30
    MOVE G6C, 110,  40
    WAIT

    RETURN


��������_����_������:
    GOSUB Leg_motor_mode3
    SPEED 4
    '�����ʱ���
    MOVE G6D,  96,  87, 132,  98, 108
    MOVE G6A, 104,  92, 126, 100,  94
    MOVE G6C, 100,  30
    MOVE G6B, 100,  30
    WAIT

    SPEED 12'����ӵ�
    '�޹ߵ��
    MOVE G6D,  92, 116, 95, 109, 114
    MOVE G6A, 112,  94, 126, 97, 94
    MOVE G6C,  90,  30
    MOVE G6B, 110,  40
    WAIT

    RETURN



��������_�߰�_����:
    SPEED 10
    '�����߻�������
    MOVE G6A,  87,  60, 143, 117, 114
    MOVE G6D, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A, 112, 92, 124, 104, 93
    MOVE G6D, 87, 109, 135, 75, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A, 113,  93, 126,  97,  94
    MOVE G6D,  92, 116,  85, 114, 114
    MOVE G6B, 110
    MOVE G6C,  90
    WAIT

    RETURN


��������_�߰�_������:
    SPEED 10
    '�����߻�������
    MOVE G6D,  87,  60, 143, 117, 114
    MOVE G6A, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D, 112,  92, 124, 104,  93
    MOVE G6A,  87, 109, 135,  75, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D, 113,  93, 126,  97,  94
    MOVE G6A,  92, 116,  85, 114, 114
    MOVE G6C, 110
    MOVE G6B,  90
    WAIT

    RETURN



ª����������1_�߰�_����:
    SPEED 10
    '�����߻�������
    MOVE G6A,84, 70, 143, 107, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,86, 100, 135, 82, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN


ª����������1_�߰�_������:
    SPEED 10
    '�����߻�������
    MOVE G6D,84, 70, 143, 107, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,86, 100, 135, 82, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN


ª����������2_�߰�_����:
    SPEED 10
    '�����߻�������
    MOVE G6A,84, 70, 143, 100, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,86, 96, 135, 92, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN


ª����������2_�߰�_������:
    SPEED 10
    '�����߻�������
    MOVE G6D,84, 70, 143, 100, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,86, 96, 135, 92, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN


ª����������3_�߰�_����:
    SPEED 10
    '�����߻�������
    MOVE G6A,83, 84, 143, 96, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A,112, 92, 124, 100, 93
    MOVE G6D,85, 96, 135, 88, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN


ª����������3_�߰�_������:
    SPEED 10
    '�����߻�������
    MOVE G6D,83, 84, 143, 96, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D,112, 92, 124, 100, 93
    MOVE G6A,85, 96, 135, 88, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN


������������_�߰�_����:
    HIGHSPEED SETON
    SPEED 5
    '�����߻�������
    MOVE G6A,87, 60, 143, 117, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT
    HIGHSPEED SETOFF

    SPEED 5
    '�޹��߽��̵�
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,87, 109, 135, 75, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    HIGHSPEED SETON
    SPEED 5
    '�����ߵ��10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    HIGHSPEED SETOFF

    RETURN


������������_�߰�_������:
    HIGHSPEED SETON
    SPEED 5
    '�����߻�������
    MOVE G6D,87, 60, 143, 117, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT
    HIGHSPEED SETOFF

    SPEED 5
    '�޹��߽��̵�
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,87, 109, 135, 75, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    HIGHSPEED SETON
    SPEED 5
    '�����ߵ��10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT
    HIGHSPEED SETOFF

    RETURN


��������_��_����:
    SPEED 10
    '�޹ߵ��10
    MOVE G6A, 92, 116, 85, 114, 114
    MOVE G6D, 113, 93, 126, 97, 94
    MOVE G6B, 90,  30
    MOVE G6C, 110, 40
    WAIT

    SPEED 6
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 106, 100, 109, 114
    WAIT

    SPEED 6
    'MOVE G6A,  86,  88, 134,  93, 114,
    MOVE G6A,  86,  85, 134,  96, 114,
    MOVE G6D, 113,  93, 126, 97,  94,
    WAIT

    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,    ,  30
    MOVE G6C,    ,  30
    WAIT

    SPEED 5

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB �⺻�ڼ�

    RETURN


��������_��_������:
    SPEED 10
    '�޹ߵ��10
    MOVE G6D, 92, 116, 85, 114, 114
    MOVE G6A, 113, 93, 126, 97, 94
    MOVE G6C, 90, 30
    MOVE G6B,110, 40
    WAIT

    SPEED 6
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 106, 100, 109, 114
    WAIT

    SPEED 6
    'MOVE G6D,  86,  86, 134,  95, 114,
    MOVE G6D,  86,  85, 134,  96, 114,
    MOVE G6A, 113,  93, 126, 97,  94,
    WAIT

    SPEED 3
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6C,    ,  30
    MOVE G6B,    ,  30
    WAIT

    SPEED 5

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB �⺻�ڼ�

    RETURN


    ''''''''''''''''''''''''''''''''''''''''''''''''''''




��������_����_����:
    GOSUB Leg_motor_mode3
    SPEED 4
    '�����ʱ���
    MOVE G6A, 96, 87, 132, 98, 110
    MOVE G6D,104, 92, 126, 100, 94
    MOVE G6B,100,30
    MOVE G6C,100,30
    WAIT

    SPEED 30'����ӵ�
    '�޹ߵ��
    MOVE G6A, 92, 116, 95, 112, 114
    MOVE G6D,112, 90, 126, 100, 94
    MOVE G6B,90,  30
    MOVE G6C,110, 40
    WAIT

    RETURN

��������_����_������:
    GOSUB Leg_motor_mode3
    SPEED 4
    '�����ʱ���
    MOVE G6D, 96, 87, 132, 98, 110
    MOVE G6A,104, 92, 126, 100, 94
    MOVE G6C,100,30
    MOVE G6B,100,30
    WAIT

    SPEED 30'����ӵ�
    '�޹ߵ��
    MOVE G6D, 92, 116, 95, 112, 114
    MOVE G6A,112, 90, 126, 100, 94
    MOVE G6C,90,  30
    MOVE G6B,110, 40
    WAIT

    RETURN

��������_�߰�_����:
    SPEED 10
    '�����߻�������
    MOVE G6A,  84, 106, 149,  58, 117,
    MOVE G6D,112, 93, 126, 100, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6D,87, 60, 143, 120, 114
    MOVE G6A,112, 93, 126, 100, 94
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6D, 92, 116, 95, 112, 114
    MOVE G6A,112, 90, 126, 100, 94
    MOVE G6C,90
    MOVE G6B,110
    WAIT

    RETURN

��������_�߰�_������:
    SPEED 10
    '�����߻�������
    MOVE G6D,  84, 106, 149,  58, 117,
    MOVE G6A,112, 93, 126, 100, 94
    WAIT

    SPEED 4
    '�޹��߽��̵�
    MOVE G6A,87, 60, 143, 120, 114
    MOVE G6D,112, 93, 126, 100, 94
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '�����ߵ��10
    MOVE G6A, 92, 116, 95, 112, 114
    MOVE G6D,112, 90, 126, 100, 94
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    RETURN

��������_��_����:
    SPEED 10
    '�޹ߵ��10
    MOVE G6A, 92, 116, 85, 117, 114
    MOVE G6D, 113, 93, 126, 100, 94
    MOVE G6B, 90, 30
    MOVE G6C,110, 40
    WAIT

    SPEED 6
    MOVE G6D,113, 93, 126, 100, 94
    MOVE G6A,92, 106, 100, 112, 114
    WAIT

    SPEED 6
    MOVE G6A,  86,  85, 134,  99, 114,
    MOVE G6D, 113,  93, 126, 100,  94,
    WAIT

    SPEED 3
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6C,    ,  30
    MOVE G6B,    ,  30

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB �⺻�ڼ�

    RETURN

��������_��_������:
    SPEED 10
    '�޹ߵ��10
    MOVE G6D, 92, 116, 85, 117, 114
    MOVE G6A, 113, 93, 126, 100, 94
    MOVE G6C, 90, 30
    MOVE G6B,110, 40
    WAIT

    SPEED 6
    MOVE G6A,113, 93, 126, 100, 94
    MOVE G6D,92, 106, 100, 112, 114
    WAIT

    SPEED 6
    MOVE G6D,  86,  85, 134,  99, 114,
    MOVE G6A, 113,  93, 126, 100,  94,
    WAIT

    SPEED 3
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6C,    ,  30
    MOVE G6B,    ,  30

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB �⺻�ڼ�

    RETURN


    ''''''''''''''''''''''''''''''''''''''''''''''''''''

��������:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
��������_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ��������_�߰�_����
        ELSE
            GOSUB ��������_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ��������_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


������������:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
������������_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ������������_�߰�_����
        ELSE
            GOSUB ������������_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ������������_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


ª����������1:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
ª����������1_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ª����������1_�߰�_����
        ELSE
            GOSUB ª����������1_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ª����������1_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


ª����������2:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
ª����������2_LOOP:
    IF Ƚ�� > 0 THEN
        IF A = 0 THEN
            GOSUB ª����������2_�߰�_����
        ELSE
            GOSUB ª����������2_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ª����������2_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


ª����������3:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
ª����������3_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ª����������3_�߰�_����
        ELSE
            GOSUB ª����������3_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ª����������3_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


��������:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: ���ʹ��� ���÷��� ����
    ' A = 1: ������ ���� ���÷��� ����
    IF A = 0 THEN
        GOSUB ��������_����_����
    ELSE
        GOSUB ��������_����_������
    ENDIF

    I = Ƚ��
��������_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ��������_�߰�_����
        ELSE
            GOSUB ��������_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ��������_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ��������_��_����
    ELSE
        GOSUB ��������_��_������
    ENDIF

    RETURN


    ''''''''''''''''''''''''''''''''''''''''''''''''''''

����_�غ�:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A, 100, 158,  25, 145, 100,
    MOVE G6D, 100, 158,  25, 145,  99,
    MOVE G6B, 159,  10,  90,  ,  ,
    MOVE G6C, 159,  10,  90,  ,  ,
    WAIT

    SPEED 1
    MOVE G6A, 100, 170,  35, 160, 100,
    MOVE G6D, 100, 170,  35, 160,  99,
    MOVE G6B, 159,  10,  90,  ,  ,
    MOVE G6C, 159,  10,  90,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A, 100, 146,  76, 160, 100,
    MOVE G6D, 100, 146,  76, 160, 100,
    MOVE G6B, 190,  10,  90,  ,  ,
    MOVE G6C, 190,  10,  90,  ,  ,
    WAIT

    SPEED 8
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6D, 100, 133, 135, 116, 100,
    MOVE G6B, 172,  10,  90,  ,  ,
    MOVE G6C, 172,  10,  90,  ,  ,
    WAIT
    GOSUB All_motor_mode2

    RETURN

����_����_������:
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6D, 100, 133, 135, 116, 100,
    MOVE G6B, 172,  10,  90,  ,  ,
    MOVE G6C, 172,  10,  90,  ,  ,
    WAIT

    SPEED 15
    MOVE G6D, 100, 141,  81, 161, 100,
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6C, 186,  22,  71,  ,  ,
    MOVE G6B, 172,  22,  71,  ,  ,
    WAIT

    GOSUB All_motor_mode2

    RETURN

����_�߰�_����:
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    'SPEED 15
    'MOVE G6A, 100, 133, 135, 116, 100,
    'MOVE G6D, 100, 141,  81, 161, 100,
    'MOVE G6B, 172,  22,  71,  ,  ,
    'MOVE G6C, 186,  22,  71,  ,  ,
    'WAIT

    SPEED 15
    MOVE G6A,  91, 131, 135, 115,  98, 100
    MOVE G6D, 113, 149,  68, 161, 100, 100
    MOVE G6B, 174,  10, 102, 100, 100, 101
    MOVE G6C, 184,  24,  68, 100, 100, 102
    WAIT

    SPEED 15
    MOVE G6A,  91, 131, 135, 115,  98,
    MOVE G6D, 113, 149,  68, 161, 100,
    MOVE G6B, 190,  10, 102,  ,  ,
    MOVE G6C, 179,  24,  68,  ,  ,
    WAIT

    'HIGHSPEED SETOFF
    SPEED 5
    MOVE G6A, 100, 170,  80, 136, 100,
    MOVE G6D, 100, 133, 135, 116, 100,
    MOVE G6B, 186,  22,  71,  ,  ,
    MOVE G6C, 172,  22,  71,  ,  ,
    WAIT

    'HIGHSPEED SETON
    SPEED 15
    MOVE G6A, 100, 141,  81, 161, 100,
    MOVE G6D, 100, 133, 135, 116, 100,
    MOVE G6B, 186,  22,  71,  ,  ,
    MOVE G6C, 172,  22,  71,  ,  ,
    WAIT

    HIGHSPEED SETOFF
    GOSUB All_motor_mode2

    RETURN

����_�߰�_������:
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    'SPEED 15
    'MOVE G6D, 100, 133, 135, 116, 100,
    'MOVE G6A, 100, 141,  81, 161, 100,
    'MOVE G6C, 172,  22,  71,  ,  ,
    'MOVE G6B, 186,  22,  71,  ,  ,
    'WAIT

    SPEED 15
    MOVE G6D,  91, 131, 135, 115,  98, 100
    MOVE G6A, 113, 149,  68, 161, 100, 100
    MOVE G6C, 174,  10, 102, 100, 100, 101
    MOVE G6B, 184,  24,  68, 100, 100, 102
    WAIT

    SPEED 15
    MOVE G6D,  91, 131, 135, 115,  98,
    MOVE G6A, 113, 149,  68, 161, 100,
    MOVE G6C, 190,  10, 102,  ,  ,
    MOVE G6B, 179,  24,  68,  ,  ,
    WAIT

    'HIGHSPEED SETOFF
    SPEED 5
    MOVE G6D, 100, 170,  80, 136, 100,
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6C, 186,  22,  71,  ,  ,
    MOVE G6B, 172,  22,  71,  ,  ,
    WAIT

    'HIGHSPEED SETON
    SPEED 15
    MOVE G6D, 100, 141,  81, 161, 100,
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6C, 186,  22,  71,  ,  ,
    MOVE G6B, 172,  22,  71,  ,  ,
    WAIT

    HIGHSPEED SETOFF
    GOSUB All_motor_mode2

    RETURN

����_��_����:
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6D, 100, 141,  81, 161, 100,
    MOVE G6A, 100, 133, 135, 116, 100,
    MOVE G6C, 186,  22,  71,  ,  ,
    MOVE G6B, 172,  22,  71,  ,  ,
    WAIT

    SPEED 8
    MOVE G6D, 100, 141,  81, 161, 100,
    MOVE G6A, 100, 141,  81, 161, 100,
    MOVE G6C, 186,  22,  71,  ,  ,
    MOVE G6B, 172,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  90, 141,  88, 162, 142,
    MOVE G6D,  90, 141,  88, 162, 142,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  73, 167,  42, 162, 142,
    MOVE G6D,  73, 167,  42, 162, 142,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  52, 170,  23, 115, 144,
    MOVE G6D,  52, 170,  23, 115, 144,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  94, 170,  23, 115, 104,
    MOVE G6D,  94, 170,  23, 115, 104,
    MOVE G6B, 159,  22,  71,  ,  ,
    MOVE G6C, 159,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT

    GOSUB All_motor_mode2

    RETURN

����_��_������:
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A, 100, 141,  81, 161, 100,
    MOVE G6D, 100, 133, 135, 116, 100,
    MOVE G6B, 186,  22,  71,  ,  ,
    MOVE G6C, 172,  22,  71,  ,  ,
    WAIT

    SPEED 8
    MOVE G6A, 100, 141,  81, 161, 100,
    MOVE G6D, 100, 141,  81, 161, 100,
    MOVE G6B, 186,  22,  71,  ,  ,
    MOVE G6C, 172,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6D,  90, 141,  88, 162, 142,
    MOVE G6A,  90, 141,  88, 162, 142,
    MOVE G6C, 172,  22,  71,  ,  ,
    MOVE G6B, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6D,  73, 167,  42, 162, 142,
    MOVE G6A,  73, 167,  42, 162, 142,
    MOVE G6C, 172,  22,  71,  ,  ,
    MOVE G6B, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6D,  52, 170,  23, 115, 144,
    MOVE G6A,  52, 170,  23, 115, 144,
    MOVE G6C, 172,  22,  71,  ,  ,
    MOVE G6B, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6D,  94, 170,  23, 115, 104,
    MOVE G6A,  94, 170,  23, 115, 104,
    MOVE G6C, 159,  22,  71,  ,  ,
    MOVE G6B, 159,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6C,100,  30,  80, 100,    ,
    MOVE G6B,100,  30,  80, 100,    ,
    WAIT

    GOSUB All_motor_mode2

    RETURN


    ''''''''''''''''''''''''''''''''''''''''''''''''''''

����:
    HIGHSPEED SETOFF

    ' A = 0~1 ������ ��
    A = RND
    A = A % 2

    ' A = 0: �������� �ռ� ����
    ' A = 1: ������ ���� �ռ� ����
    GOSUB ����_�غ�

    I = Ƚ��
����_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB ����_�߰�_����
        ELSE
            GOSUB ����_�߰�_������
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO ����_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB ����_��_����
    ELSE
        GOSUB ����_��_������
    ENDIF

    RETURN



    ''''''''''''''''''''''''''''''''''''''''''''''''''''

������������_��ܺε�����:
    TEMP = 0

    SPEED 8
    HIGHSPEED SETOFF


    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  90, 101
        MOVE G6D,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_��ܺε�����_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  90, 101
        MOVE G6A,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_��ܺε�����_2
    ENDIF


    '**********************
������������_��ܺε�����_1:
    MOVE G6A,95,  95, 120, 97, 104
    MOVE G6D,104,  77, 146,  88,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  85, 130, 100, 104
    MOVE G6D,104,  79, 146,  86,  100
    WAIT

    MOVE G6A,103,   85, 130, 100,  100
    MOVE G6D, 95,  79, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_��ܺε�����_����
    ENDIF
    GOTO ������������_��ܺε�����_2
    '*********************************
������������_��ܺε�����_2:
    MOVE G6D,95,  95, 120, 97, 104
    MOVE G6A,104,  77, 146,  88,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95,  85, 130, 100, 104
    MOVE G6A,104,  79, 146,  86,  100
    WAIT

    MOVE G6D,103,   85, 130, 100,  100
    MOVE G6A, 95,  79, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_��ܺε�����_����
    ENDIF
    GOTO ������������_��ܺε�����_1
    '******************************************
������������_��ܺε�����_����:
    IF ���� = 1 THEN
        MOVE G6A,95,  85, 130, 97, 100
        MOVE G6D,104,  77, 146,  88,  100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95,  85, 130, 97, 100
        MOVE G6A,104,  77, 146,  88,  100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80, 100, ,
    MOVE G6C,100,  30,  80, 100, ,
    WAIT

    RETURN


������������:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  90, 101
        MOVE G6D,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  90, 101
        MOVE G6A,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_2
    ENDIF
    '**************************************
������������_1:
    MOVE G6A,95,  95, 120, 97, 104
    MOVE G6D,104,  75, 144,  86,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  85, 130, 100, 104
    MOVE G6D,104,  77, 144,  84,  100
    WAIT

    MOVE G6A,103,   85, 130, 100,  100
    MOVE G6D, 95,  77, 144,  84, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_����
    ENDIF
    GOTO ������������_2
    '*********************************
������������_2:
    MOVE G6D,95,  95, 120, 97, 104
    MOVE G6A,104,  77, 146,  88,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95,  85, 130, 100, 104
    MOVE G6A,104,  79, 146,  86,  100
    WAIT

    MOVE G6D,103,   85, 130, 100,  100
    MOVE G6A, 95,  79, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_����
    ENDIF
    GOTO ������������_1
    '******************************************
������������_����:
    IF ���� = 1 THEN
        MOVE G6A,95,  85, 130, 97, 100
        MOVE G6D,104,  77, 146,  88,  100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95,  85, 130, 97, 100
        MOVE G6A,104,  77, 146,  88,  100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    RETURN
    '*********************************

������������_����ȭ:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  77, 145,  90, 101
        MOVE G6D,101,  78, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ_1
    ELSE
        ������� = 0
        MOVE G6D,95,  77, 145,  90, 101
        MOVE G6A,101,  78, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ_2
    ENDIF
    '**************************************
������������_����ȭ_1:
    MOVE G6A,95,  101, 120, 97, 104
    MOVE G6D,104,  81, 144,  86,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  91, 130, 100, 104
    MOVE G6D,104,  83, 144,  84,  100
    WAIT

    MOVE G6A,103,   91, 130, 100,  100
    MOVE G6D, 95,  83, 144,  84, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_����ȭ_����
    ENDIF
    GOTO ������������_����ȭ_2
    '*********************************
������������_����ȭ_2:
    MOVE G6D,95,  101, 120, 97, 104
    MOVE G6A,104,  83, 146,  88,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95,  91, 130, 100, 104
    MOVE G6A,104,  85, 146,  86,  100
    WAIT

    MOVE G6D,103,   91, 130, 100,  100
    MOVE G6A, 95,  85, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_����ȭ_����
    ENDIF
    GOTO ������������_����ȭ_1
    '******************************************
������������_����ȭ_����:
    IF ���� = 1 THEN
        MOVE G6A,95,  91, 130, 97, 100
        MOVE G6D,104,  83, 146,  88,  100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95,  91, 130, 97, 100
        MOVE G6A,104,  83, 146,  88,  100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    RETURN
    '*********************************

������������_����ȭ2:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  78, 145,  90, 101
        MOVE G6D,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ2_1
    ELSE
        ������� = 0
        MOVE G6D,95,  78, 145,  90, 101
        MOVE G6A,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ2_2
    ENDIF
    '**************************************
������������_����ȭ2_1:
    MOVE G6A,95,  100, 120, 97, 104
    MOVE G6D,104,  80, 144,  86,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  90, 130, 100, 104
    MOVE G6D,104,  82, 144,  84,  100
    WAIT

    MOVE G6A,103,   90, 130, 100,  100
    MOVE G6D, 95,  82, 144,  84, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_����ȭ2_����
    ENDIF
    GOTO ������������_����ȭ2_2
    '*********************************
������������_����ȭ2_2:
    MOVE G6D,95,  100, 120, 97, 104
    MOVE G6A,104,  82, 146,  88,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95,  90, 130, 100, 104
    MOVE G6A,104,  84, 146,  86,  100
    WAIT

    MOVE G6D,103,   90, 130, 100,  100
    MOVE G6A, 95,  84, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_����ȭ2_����
    ENDIF
    GOTO ������������_����ȭ2_1
    '******************************************
������������_����ȭ2_����:
    IF ���� = 1 THEN
        MOVE G6A,95,  90, 130, 97, 100
        MOVE G6D,104,  82, 146,  88,  100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95,  90, 130, 97, 100
        MOVE G6A,104,  82, 146,  88,  100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    RETURN
    '*********************************


������������_����ȭ3:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  78, 145,  90, 101
        MOVE G6D,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ3_1
    ELSE
        ������� = 0
        MOVE G6D,95,  78, 145,  90, 101
        MOVE G6A,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_����ȭ3_2
    ENDIF
    '**************************************
������������_����ȭ3_1:
    MOVE G6A,95,  97, 120, 97, 104
    MOVE G6D,104,  77, 144,  86,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  87, 130, 100, 104
    MOVE G6D,104,  79, 144,  84,  100
    WAIT

    MOVE G6A,103,   87, 130, 100,  100
    MOVE G6D, 95,  79, 144,  84, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_����ȭ3_����
    ENDIF
    GOTO ������������_����ȭ3_2
    '*********************************
������������_����ȭ3_2:
    MOVE G6D,95,  97, 120, 97, 104
    MOVE G6A,104,  79, 146,  88,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95,  87, 130, 100, 104
    MOVE G6A,104,  81, 146,  86,  100
    WAIT

    MOVE G6D,103,   87, 130, 100,  100
    MOVE G6A, 95,  81, 146,  86, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_����ȭ3_����
    ENDIF
    GOTO ������������_����ȭ3_1
    '******************************************
������������_����ȭ3_����:
    IF ���� = 1 THEN
        MOVE G6A,95,  87, 130, 97, 100
        MOVE G6D,104,  79, 146,  88,  100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95,  87, 130, 97, 100
        MOVE G6A,104,  79, 146,  88,  100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  78, 145,  93, 100
    MOVE G6D,100,  78, 145,  93, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    RETURN
    '*********************************


����������������:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  94, 125,  97, 101
        MOVE G6D,101,  95, 125,  97, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ����������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  94, 125,  97, 101
        MOVE G6A,101,  95, 125,  97, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ����������������_2
    ENDIF
    '**************************************
����������������_1:
    MOVE G6A,95,  113, 100, 104, 104
    MOVE G6D,104,  93, 124,  93,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT

    MOVE G6A,95,  103, 110, 107, 104
    MOVE G6D,104,  95, 124,  91,  100
    WAIT

    MOVE G6A,103, 103, 110, 107,  100
    MOVE G6D, 95,  95, 124,  91, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ����������������_����
    ENDIF
    GOTO ����������������_2
    '*********************************
����������������_2:
    MOVE G6D,95, 113, 100, 104, 104
    MOVE G6A,104, 95, 126, 95, 102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT

    MOVE G6D,95, 103, 110, 107, 104
    MOVE G6A,104, 97, 126, 93, 100
    WAIT

    MOVE G6D,103, 103, 110, 107, 100
    MOVE G6A, 95, 97, 126, 93, 102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ����������������_����
    ENDIF
    GOTO ����������������_1
    '******************************************
����������������_����:
    IF ���� = 1 THEN
        MOVE G6A,95, 103, 110, 104, 100
        MOVE G6D,104, 95, 126, 95, 100
        MOVE G6B, 80
        MOVE G6C,120
        WAIT
    ELSE
        MOVE G6D,95, 103, 110, 104, 100
        MOVE G6A,104, 95, 126, 95, 100
        MOVE G6C, 80
        MOVE G6B,120
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100, 94, 125, 100, 100
    MOVE G6D,100, 94, 125, 100, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    RETURN
    '*********************************


������������:
    TEMP = 0

    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO ������������_2
    ENDIF
    '**********************

������������_1:
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT

    MOVE G6A,95,  90, 135, 90, 104
    MOVE G6D,104,  77, 146,  91,  100
    WAIT

    MOVE G6A, 103,  79, 146,  89, 100
    MOVE G6D,95,   65, 146, 103,  102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 0
        GOTO ������������_����
    ENDIF

    GOTO ������������_2
    '*********************************

������������_2:
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT

    MOVE G6A,104,  77, 146,  91,  100
    MOVE G6D,95,  90, 135, 90, 104
    WAIT

    MOVE G6D, 103,  79, 146,  89, 100
    MOVE G6A,95,   65, 146, 103,  102
    WAIT

    TEMP = TEMP + 1
    IF TEMP >= Ƚ�� THEN
        ���� = 1
        GOTO ������������_����
    ENDIF

    GOTO ������������_1
    '*************************************
������������_����:
    IF ���� = 0 THEN
        MOVE G6A,104,  77, 146,  91,  102
        MOVE G6D,95,  95, 120, 100, 104
        MOVE G6C,115
        MOVE G6B,85
        WAIT
    ELSE
        MOVE G6D,104,  77, 146,  91,  102
        MOVE G6A,95,  95, 120, 100, 104
        MOVE G6B,115
        MOVE G6C,85
        WAIT
    ENDIF

    HIGHSPEED SETOFF

    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80, , ,
    MOVE G6C,100,  30,  80, , ,
    WAIT

    GOSUB Leg_motor_mode1
    RETURN


��ܿ�����2: 'stair walk
    GOSUB ���̷�OFF
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 105
    MOVE G6D,95,  76, 145,  93, 105
    MOVE G6B,100,  30,  80, 100,
    MOVE G6C,100,  30,  80, 100, ,
    WAIT

    SPEED 4
    MOVE G6B,100,35
    MOVE G6C,100,35
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,106,  76, 146,  93,  96
    WAIT

    DELAY 600
    SPEED 7
    MOVE G6D,113,  78, 146,  93,  94
    MOVE G6A, 90, 100, 110, 100, 114
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A, 90, 140, 35, 130, 134
    MOVE G6D,114,  72, 155,  90,  94
    WAIT

    SPEED 6
    MOVE G6A,  80, 30, 130, 150, 114,
    MOVE G6D,114,  83, 135,  90,  94
    WAIT

    SPEED 2
    MOVE G6A,90, 40, 130, 150, 114,
    MOVE G6D,113,90, 135,  90,  90
    WAIT
    SPEED 6

    GOSUB Leg_motor_mode3
    MOVE G6A, 103, 108,  53, 162, 102,
    MOVE G6D,  97, 133, 120,  71,  95,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 101,  36,  81,  ,  ,
    WAIT

    MOVE G6A, 109, 128,  39, 163,  96,
    MOVE G6D,  95, 145, 118,  66,  98,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT


    MOVE G6A, 109, 128,  39, 163,  96,
    MOVE G6D,  92, 154, 118,  57,  103,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    MOVE G6A, 109, 128,  39, 163,  96,
    MOVE G6D,  87, 170, 109,  61, 103,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    SPEED 1
    MOVE G6A, 117, 128,  39, 163,  96,
    MOVE G6D,  84, 170, 124,  46, 107,
    'MOVE G6D,  89, 170, 109,  61, 102,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    MOVE G6A, 121, 131,  47, 153,  93,
    MOVE G6D,  83, 170, 109,  61, 111,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    DELAY 300

    SPEED 4
    MOVE G6A, 121, 131,  47, 153,  93,
    MOVE G6D,  82, 158,  37, 135, 106,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    MOVE G6A, 109, 131,  47, 153,  91,
    MOVE G6D,  91, 133,  41, 156, 107,
    MOVE G6B, 101,  35,  81,  ,  ,
    MOVE G6C, 103,  36,  82,  ,  ,
    WAIT

    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT

    RETURN

    GOSUB Leg_motor_mode3

    SPEED 4
    MOVE G6A, 109, 90, 80, 160,100,
    MOVE G6D,79,  90, 165,  50, 103
    MOVE G6B,160,85
    MOVE G6C,160,35
    WAIT
    DELAY 1500
    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 2
    MOVE G6A, 113, 90, 100, 150,95,
    MOVE G6D,100,  90, 165,  60, 109
    WAIT
    DELAY 500

    SPEED 4
    MOVE G6D,100, 140, 160,  60, 109
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  150, 40,  140, 108
    WAIT


    SPEED 10
    MOVE G6A, 114, 90, 105, 130,95,
    MOVE G6D,90,  95, 83,  145, 112
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT


    SPEED 10
    MOVE G6A, 110, 90, 105, 130,95,
    MOVE G6D,80,  85, 103,  135, 112
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT


    SPEED 4
    MOVE G6D, 100, 90, 110, 125,103
    MOVE G6A,100,  90, 110,  125, 103
    MOVE G6B,110,80
    MOVE G6C,110,80
    WAIT

    SPEED 4
    GOSUB Leg_motor_mode2
    GOSUB ���̷�ON

    RETURN


����������:

    GOSUB ���̷�OFF
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 105
    MOVE G6D,95,  76, 145,  93, 105
    MOVE G6B,100,  30,  80, 100,
    MOVE G6C,100,  30,  80, 100, ,
    WAIT

    SPEED 4
    MOVE G6B,100,35
    MOVE G6C,100,35
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,106,  76, 146,  93,  96
    WAIT

    DELAY 600
    SPEED 7
    MOVE G6D,115,  78, 146,  93,  94
    MOVE G6A, 90, 100, 110, 100, 114
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A, 90, 140, 50, 130, 130
    MOVE G6D,117,  72, 155,  90,  94
    WAIT

    SPEED 6
    MOVE G6A,  85, 40, 130, 150, 114,
    MOVE G6D,117,  85, 135,  90,  94
    WAIT

    SPEED 6
    MOVE G6A,90, 40, 130, 150, 114,
    MOVE G6D,113,92, 135,  90,  90
    WAIT


    GOSUB Leg_motor_mode3

    SPEED 4
    MOVE G6A, 115, 100, 80, 160,100,
    MOVE G6D, 79,  120, 160,  50, 103
    MOVE G6B,160,85
    MOVE G6C,160,35
    WAIT
    DELAY 1500
    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 2
    MOVE G6A, 113, 90, 100, 150,95,
    MOVE G6D,100,  90, 165,  60, 109
    WAIT
    DELAY 500

    SPEED 4
    MOVE G6D,100, 140, 160,  60, 109
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  150, 40,  140, 108
    WAIT


    SPEED 10
    MOVE G6A, 114, 90, 105, 130,95,
    MOVE G6D,90,  95, 83,  145, 112
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT


    SPEED 10
    MOVE G6A, 110, 90, 105, 130,95,
    MOVE G6D,80,  85, 103,  135, 112
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT


    SPEED 4
    MOVE G6D, 100, 90, 110, 125,103
    MOVE G6A,100,  90, 110,  125, 103
    MOVE G6B,110,80
    MOVE G6C,110,80
    WAIT

    SPEED 4
    GOSUB Leg_motor_mode2
    GOSUB ���̷�ON

    GOSUB �⺻�ڼ�

    RETURN



��ܿ�����: 'stair walk
    GOSUB ���̷�OFF
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 105
    MOVE G6D,95,  76, 145,  93, 105
    MOVE G6B,100,  30,  80, 100,
    MOVE G6C,100,  30,  80, 100, ,
    WAIT

    SPEED 4
    MOVE G6B,100,35
    MOVE G6C,100,35
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,106,  76, 146,  93,  96
    WAIT

    DELAY 600
    SPEED 7
    MOVE G6D,115,  78, 146,  93,  94
    MOVE G6A, 90, 100, 110, 100, 114
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A, 90, 140, 35, 130, 134
    MOVE G6D,115,  72, 155,  90,  94
    WAIT

    SPEED 6
    MOVE G6A,  80, 30, 130, 150, 114,
    MOVE G6D,114,  83, 135,  90,  94
    WAIT

    SPEED 6
    MOVE G6A,90, 40, 130, 150, 114,
    MOVE G6D,113,92, 135,  90,  90
    WAIT

    'SPEED 6
    'MOVE G6A,  91,  39, 133, 146, 111,
    'MOVE G6D, 114, 108, 123,  87,  86,
    'WAIT


    'DELAY 1000

    'SPEED 2
    'MOVE G6A, 107,  85,  77, 156,  96,
    'MOVE G6D,  98, 114, 142,  61,  95,
    'WAIT

    GOSUB Leg_motor_mode3

    SPEED 4
    MOVE G6A, 109, 92, 80, 160,100,
    MOVE G6D,79,  90, 165,  50, 103
    MOVE G6B,160,85
    MOVE G6C,160,35
    WAIT
    DELAY 1500
    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 2
    MOVE G6A, 113, 90, 100, 150,95,
    MOVE G6D,100,  90, 165,  60, 109
    WAIT
    DELAY 500

    SPEED 4
    MOVE G6D,100, 140, 160,  60, 109
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  150, 40,  140, 108
    WAIT


    SPEED 10
    MOVE G6A, 114, 90, 105, 130,95,
    MOVE G6D,90,  95, 83,  145, 112
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT


    SPEED 10
    MOVE G6A, 110, 90, 105, 130,95,
    MOVE G6D,80,  85, 103,  135, 112
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT


    SPEED 4
    MOVE G6D, 100, 90, 110, 125,103
    MOVE G6A,100,  90, 110,  125, 103
    MOVE G6B,110,80
    MOVE G6C,110,80
    WAIT

    SPEED 4
    GOSUB Leg_motor_mode2
    GOSUB ���̷�ON

    RETURN

��ܳ�����: 'stair down
    GOSUB ���̷�OFF
    GOSUB All_motor_mode3

    SPEED 4 '�ٸ� ������
    MOVE G6C,100,80
    MOVE G6D, 87,  71, 152,  91, 110
    MOVE G6A,103,  76, 145,  93,  94
    MOVE G6B,100,40
    WAIT

    SPEED 7
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,115,  76, 145,  93,  90
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 7
    MOVE G6D,  90, 30, 155, 150, 120,
    MOVE G6A,115,  65, 155,  90,  90
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 3
    MOVE G6D,  90, 30, 175, 150, 114,
    MOVE G6A,113,  112, 65,  140,  90
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 7
    MOVE G6D,90, 10, 150, 150, 110
    MOVE G6A,110,  161, 50,  120,90
    MOVE G6C,140,50
    MOVE G6B,140,40
    WAIT
    '****************************
    SPEED 7
    MOVE G6D,100, 30, 150, 150, 100
    MOVE G6A,100,  155, 70,  100,100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT

    SPEED 7
    MOVE G6C,141,38
    MOVE G6B,100,100
    MOVE G6D,114, 66, 125, 150, 94
    MOVE G6A,80,  125, 140,  75,114
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 7
    MOVE G6D,114, 66, 130, 150, 94
    MOVE G6A,80,  125, 50,  150,114
    WAIT

    SPEED 7
    MOVE G6D,116, 75, 130, 120, 94
    MOVE G6A,90,  73, 90,  167,114
    MOVE G6B,100,38
    WAIT

    SPEED 7
    MOVE G6D,112, 80, 130, 110, 94
    MOVE G6A,80,  75,130,  115,114
    MOVE G6C,130,50
    MOVE G6B,100,40
    WAIT

    SPEED 7
    MOVE G6A,80,  80, 130,  105, 110
    WAIT

    SPEED 7
    MOVE G6A,90,  80, 130,  105, 110
    MOVE G6D, 100, 80, 130, 105,100,
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    DELAY 100

    SPEED 10
    GOSUB �⺻�ڼ�

    GOSUB All_motor_Reset
    GOSUB ���̷�ON

    RETURN


���������غ�:

    MOVE G6A,100,  90, 125, 100, 100
    MOVE G6D,100,  90, 125, 100, 100
    MOVE G6B,100,  90,  30,    ,    , 100
    MOVE G6C,100,  90,  30,    ,    , 100

    RETURN

���������غ�_�����ʿ�����_��:
    SPEED 10
    MOVE G6A, 100,  92, 125, 100, 107,
    MOVE G6D,  97,  97, 120, 100, 100,
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6A,  89,  92, 125, 100, 110,
    MOVE G6D, 105,  87, 130,  98,  96,
    'MOVE G6A,  89,  92, 125, 100, 110,
    'MOVE G6D, 105,  97, 120, 100,  96,
    WAIT

    SPEED 6
    MOVE G6A,100,  90, 125, 100, 100
    MOVE G6D,100,  90, 125, 100, 100
    WAIT

    RETURN

���������غ�_���ʿ�����_��:
    SPEED 10
    MOVE G6D, 100,  92, 125, 100, 107,
    MOVE G6A,  97,  97, 120, 100, 100,
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 12
    MOVE G6D,  89,  92, 125, 100, 110,
    MOVE G6A, 105,  87, 130,  98,  96,
    'MOVE G6A,  89,  92, 125, 100, 110,
    'MOVE G6D, 105,  97, 120, 100,  96,
    WAIT

    SPEED 6
    MOVE G6D,100,  90, 125, 100, 100
    MOVE G6A,100,  90, 125, 100, 100
    WAIT

    RETURN

�����ʱ�����:
    GOSUB ���̷�OFF
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 100,  66, 175,  75, 100,
    MOVE G6D, 100,  65, 175,  75, 100,
    MOVE G6B, 100, 121, 150,  ,  ,
    MOVE G6C, 100, 108, 115,  ,  ,
    WAIT

    SPEED 15
    MOVE G6A,  90,  66, 175,  75, 110,
    MOVE G6D, 110,  65, 175,  75,  90,
    MOVE G6B, 100, 121, 150,  ,  ,
    MOVE G6C, 100, 108, 115,  ,  ,
    WAIT

    MOVE G6A,  84,  66, 175,  75,  81,
    MOVE G6D, 109,  65, 175,  75, 125,
    MOVE G6B, 100, 121, 150,  ,  ,
    MOVE G6C, 100, 108, 115,  ,  ,
    WAIT

    MOVE G6A,  84,  66, 175,  75,  81,
    MOVE G6D, 109,  65, 175,  75, 183,
    MOVE G6B, 100, 121, 150,  ,  ,
    MOVE G6C, 100, 108, 115,  ,  ,
    WAIT


    MOVE G6A,  83,  66, 175,  75, 190,
    MOVE G6D, 109,  65, 175,  75, 183,
    MOVE G6B, 103, 137, 190,  ,  ,
    MOVE G6C, 100, 140, 190,  ,  ,
    WAIT

    DELAY 1500

    MOVE G6A, 124, 168,  25, 119, 185,
    MOVE G6D, 109,  65, 175,  75, 183,
    MOVE G6B, 103, 137, 190,  ,  ,
    MOVE G6C, 100, 140, 190,  ,  ,
    WAIT
    DELAY 300

    MOVE G6A, 124, 168,  25, 119, 185,
    MOVE G6D, 110,  65, 175,  75,  80,
    MOVE G6B, 103, 137, 135,  ,  ,
    MOVE G6C, 100, 140, 190,  ,  ,
    WAIT
    DELAY 300

    MOVE G6A,  97, 168,  25, 119, 185,
    MOVE G6D,  68,  65, 175,  75,  80,
    MOVE G6B, 103, 137, 106,  ,  ,
    MOVE G6C, 100, 140, 190,  ,  ,
    WAIT
    DELAY 300

    MOVE G6A,  97, 168,  25, 119, 156,
    MOVE G6D,  68,  65, 175,  75,  80,
    MOVE G6B, 103,  98,  ,  ,  ,
    MOVE G6C, 100, 140, 190,  ,  ,
    WAIT

    MOVE G6A,  83, 168,  24, 119, 117,
    MOVE G6D,  83, 168,  24, 119, 117,
    MOVE G6B, 103,  98, 106,  ,  ,
    MOVE G6C, 100,  98, 106,  ,  ,
    WAIT

    MOVE G6A,  83, 168,  24, 119, 117,
    MOVE G6D,  83, 168,  24, 119, 117,
    MOVE G6B, 103,  98, 106,  ,  ,
    MOVE G6C, 100,  98, 106,  ,  ,
    WAIT

    MOVE G6A, 102, 168,  24, 119,  97,
    MOVE G6D, 102, 168,  24, 119,  97,
    MOVE G6B, 100,  98, 106,  ,  ,
    MOVE G6C, 100,  98, 106,  ,  ,
    WAIT

    SPEED 4
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT


    GOSUB Leg_motor_mode2
    GOSUB ���̷�ON

    RETURN

���:
    GOSUB ���̷�OFF
    'GOSUB All_motor_mode2
    SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT

    MOVE G6B, 100,  100,  40,  ,  ,
    MOVE G6C, 100,  100,  40,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A, 100,  60, 175,  84,  98,
    MOVE G6D, 100,  60, 175,  84,  98,
    MOVE G6B, 190,  30,  80,  ,  ,
    MOVE G6C, 190,  30,  80,  ,  ,
    WAIT
    DELAY 500

    'GOSUB All_motor_mode3
    SPEED 15
    MOVE G6A, 100,  80, 175,  84,  98,
    MOVE G6D, 100,  80, 175,  84,  98,
    MOVE G6B, 190,  30,  80,  ,  ,
    MOVE G6C, 190,  30,  80,  ,  ,
    WAIT

    SPEED 8
    MOVE G6D, 110, 101,  80,  10, 103,  ,
    WAIT

    SPEED 8
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    MOVE G6A, 110, 101,  80,  10, 103,

    WAIT

    SPEED 8
    MOVE G6A, 110, 101,  80,  10, 103,  ,
    MOVE G6D, 110, 101,  80,  10, 103,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT
    DELAY 300

    MOVE G6A, 110, 20,  80,  100, 103,  ,
    MOVE G6D, 110, 20,  80,  100, 103,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 110, 20,  80,  60, 103,  ,
    MOVE G6D, 110, 20,  80,  60, 103,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 110, 20,  80,  60, 170,  ,
    MOVE G6D, 110, 20,  80,  60, 170,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 120, 20,  100,  100, 170,  ,
    MOVE G6D, 120, 20,  100,  100, 170,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 50, 20,  120,  100, 170,  ,
    MOVE G6D, 50, 20,  120,  100, 170,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 90, 100,  120,  100, 110,  ,
    MOVE G6D, 90, 100,  120,  100, 110,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 103, 170, 144,  91, 116,
    MOVE G6D, 103, 170, 144,  91, 116,
    MOVE G6B, 190, 100,  80,  ,  ,
    MOVE G6C, 190, 100,  80,  ,  ,
    WAIT
    DELAY 300

    MOVE G6A, 103, 170, 144,  91, 116,
    MOVE G6D, 103, 170, 144,  91, 116,
    MOVE G6B, 189, 135,  10,  ,  ,
    MOVE G6C, 186, 135,  10,  ,  ,
    WAIT

    MOVE G6A, 114, 170,  86, 160, 128,
    MOVE G6D, 114, 170,  86, 160, 128,
    MOVE G6B, 190,  10, 170,  ,  ,
    MOVE G6C, 190,  10, 170,  ,  ,
    WAIT

    MOVE G6B, 185,  57,  52,  ,  ,
    MOVE G6C, 185,  57,  52,  ,  ,
    MOVE G6A,  95, 169,  56, 161, 125,
    MOVE G6D,  95, 169,  56, 161, 125,
    WAIT

    SPEED 5
    MOVE G6A,  73, 167,  42, 162, 142,
    MOVE G6D,  73, 167,  42, 162, 142,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  52, 170,  23, 115, 144,
    MOVE G6D,  52, 170,  23, 115, 144,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 186,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,  94, 170,  23, 115, 104,
    MOVE G6D,  94, 170,  23, 115, 104,
    MOVE G6B, 159,  22,  71,  ,  ,
    MOVE G6C, 159,  22,  71,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,100
    MOVE G6C,100,  30,  80, 100,    ,100
    WAIT

    GOSUB All_motor_mode2
    GOSUB ���̷�ON

    RETURN

�������1:
    SPEED 10
    MOVE G6A,100,  80, 167,  50, 100, 100
    MOVE G6D,100,  80, 167,  50, 100, 100
    MOVE G6B,100, 145, 125, , ,
    MOVE G6C,100, 145, 122, , ,
    WAIT

    FOR I = 0 TO 4
        MOVE G6B,100, 100, 140, , , ,
        MOVE G6C,100, 100, 140, , , ,
        WAIT
        MOVE G6B,100, 165, 160, , , ,
        MOVE G6C,100, 165, 160, , , ,
        WAIT

    NEXT I
    SPEED 8
    DELAY 200
    GOSUB �⺻�ڼ�
    RETURN

������_����:
    GOSUB ���̷�OFF
    SPEED 8
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT

    MOVE G6A, 109,  92, 125, 100,  89,
    MOVE G6D,  86,  92, 125, 100, 115,
    MOVE G6B, 100,  50,  80,  ,  ,
    MOVE G6C, 100,  50,  80,  ,  ,
    WAIT

    SPEED 8
    MOVE G6A, 116,  92, 125, 100,  91,
    MOVE G6D,  91, 120,  72, 124, 119,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    SPEED 8
    MOVE G6A, 116,  93, 125, 105,  91,
    MOVE G6D,  91, 120,  72,  61, 119,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT
    SPEED 8
    MOVE G6A, 116,  90, 125, 105,  91,
    MOVE G6D,  84,  88, 122, 111, 114,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,

    MOVE G6A, 116,  88, 125, 105,  91,
    MOVE G6D,  89,  46, 159, 134, 115,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    MOVE G6A, 116,  85, 125, 105,  91,
    MOVE G6D,  89,  46, 159, 134, 115,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    MOVE G6A, 116,  85, 125, 105,  91,
    MOVE G6D,  90,  55, 150, 115, 115,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    SPEED 8
    DELAY 200

    GOSUB �⺻�ڼ�
    GOSUB ���̷�ON

    RETURN

����:

    GOSUB ���̷�OFF
    GOSUB �⺻�ڼ�




    SPEED 6
    MOVE G6B,150,  40,  90, 100, 100, 100
    MOVE G6C,150,  40,  90, 100, 100,  10
    WAIT

    SPEED 6
    MOVE G6A, 94, 125,  83, 100, 105, 100
    MOVE G6D, 94, 125,  83, 100, 105, 100
    WAIT

    SPEED 6
    MOVE G6A, 88, 150,  49, 101, 112, 100
    MOVE G6D, 88, 150,  49, 101, 112, 100
    WAIT

    SPEED 6
    MOVE G6D, 84, 166,  42, 130, 121, 100
    MOVE G6A, 84, 166,  42, 130, 121, 100
    WAIT


    DELAY 500

    SPEED 6
    MOVE G6A,108, 102,  97, 163,  97, 100
    MOVE G6D,108, 102,  97, 163,  97, 100
    WAIT

    SPEED 6
    MOVE G6A,102,  60, 158, 130,  97, 100
    MOVE G6D,102,  60, 158, 130,  97, 100
    WAIT


    SPEED 6
    MOVE G6A, 100, 50,  120, 15, 100, 100
    WAIT

    SPEED 6
    MOVE G6D, 100, 50,  120, 15, 100, 100
    WAIT

    SPEED 12
    MOVE G6B,186,  40,  90, 100, 100, 100
    MOVE G6C,186,  40,  90, 100, 100,  30
    WAIT

    SPEED 12
    MOVE G6A,111,  26, 166,  14, 175, 100
    MOVE G6D,111,  26, 166,  14, 175, 100
    MOVE G6C,186,  40,  90, 100, 100,  10
    WAIT

    DELAY 500

    SPEED 8
    MOVE G6A,100,  26, 166,  14, 110, 100
    MOVE G6D,100,  26, 166,  14, 110, 100
    WAIT

    SPEED 8
    MOVE G6B,186,  160,  100, 100, 100, 100
    MOVE G6C,186,  160,  100, 100, 100,  30
    WAIT

    SPEED 8
    MOVE G6A,105,  90,  53,  73, 114, 100
    MOVE G6B,186, 117, 105, 100, 100, 101
    MOVE G6D,105,  90,  53,  73, 114, 100
    MOVE G6C,186, 117, 105, 100, 100, 101
    WAIT

    SPEED 8
    MOVE G6A,111, 162,  25,  22, 152, 100
    MOVE G6D,111, 162,  25,  22, 152, 100
    WAIT

    SPEED 8
    MOVE G6B,186,  160,  100, 100, 100, 100
    MOVE G6C,186,  160,  100, 100, 100,  100
    MOVE G6A,111, 162,  25,  40, 152, 100
    MOVE G6D,111, 162,  25,  40, 152, 100
    WAIT

    SPEED 8
    MOVE G6A, 76, 145,  54,  57, 138, 100
    MOVE G6D, 76, 145,  54,  57, 138, 100
    MOVE G6B,186,  180,  100, 100, 100, 100
    MOVE G6C,186,  180,  100, 100, 100,  100
    WAIT

    DELAY 300

    SPEED 8
    MOVE G6B,186,  12,  90, 100, 100, 101
    MOVE G6C,186,  12,  90, 100, 100, 101
    WAIT

    SPEED 12
    MOVE G6A, 82, 144,  49,  87, 121, 100
    MOVE G6D, 82, 144,  49,  87, 121, 100
    WAIT

    SPEED 8
    MOVE G6A, 88, 126,  73, 101, 114, 100
    MOVE G6D, 88, 126,  73, 101, 114, 100
    WAIT

    SPEED 8
    MOVE G6A,94, 112,  95, 101, 109, 100
    MOVE G6D, 94, 112,  95, 101, 109, 100
    MOVE G6B, 99,  23,  90, 100, 100, 101
    MOVE G6C, 99,  23,  90, 100, 100, 101
    WAIT

    GOSUB �⺻�ڼ�





    RETURN


���ں���:

    GOSUB ���̷�OFF

    SPEED 8
    MOVE G6A, 90,  92, 125, 100, 108, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    DELAY 500


    FOR I = 1 TO 10
        SPEED 8
        MOVE G6A, 90,  92, 125, 115, 110, 100
        MOVE G6D, 90,  92, 125, 100, 110, 100
        WAIT

        SPEED 8
        MOVE G6A, 90,  92, 125, 100, 110, 100
        MOVE G6D, 90,  92, 125, 115, 110, 100
        WAIT
    NEXT I

    MOVE G6A, 90,  92, 125, 100, 110, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    GOSUB �⺻�ڼ�

    GOSUB ���̷�OFF

    END  	

�������_������:
    GOSUB ���̷�OFF

    SPEED 6
    MOVE G6B,150,  40,  90, 100, 100, 100
    MOVE G6C,150,  40,  90, 100, 100,  10

    WAIT
    
    SPEED 6
    MOVE G6A,100, 102,  97, 133,  97, 100
    MOVE G6D,100, 102,  97, 133,  97, 100
    
    WAIT

    SPEED 6
    MOVE G6A,100, 102,  97, 163,  97, 100
    MOVE G6D,100, 102,  97, 163,  97, 100
    WAIT


    SPEED 6
    MOVE G6A,102,  60, 158, 130,  97, 100
    MOVE G6D,102,  60, 158, 130,  97, 100
    WAIT


    SPEED 6
    MOVE G6A, 100, 50,  120, 15, 100, 100
    WAIT

    SPEED 6
    MOVE G6D, 100, 50,  120, 15, 100, 100
    WAIT

    SPEED 12
    MOVE G6B,183,  45,  80, 100, 100, 100
    MOVE G6C,186,  40,  90, 100, 100,  30
    WAIT

	DELAY 500
	
    SPEED 12
    MOVE G6A,111,  26, 150,  14, 175, 100
    MOVE G6D,111,  16, 160,  14, 175, 100
    MOVE G6C,186,  40,  90, 100, 100,  10
    WAIT

    DELAY 500

    SPEED 8
    MOVE G6A,100,  26, 166,  14, 110, 100
    MOVE G6D,100,  26, 166,  14, 110, 100
    WAIT
'*************************************************
'������
	
	SPEED 8
	MOVE G6A,103,  20,  71, 130, 115, 100
	MOVE G6D,103,  20,  71, 130, 115, 100
	WAIT
    
    SPEED 8
	MOVE G6A,103,  70,  150, 90, 115, 100
	MOVE G6D,103,  70,  150, 90, 115, 100
    WAIT
    
    SPEED 8
	MOVE G6B,183,  100,  100, 100, 100, 100
    MOVE G6C,186,  100,  100, 100, 100,  10
    WAIT
    
    
    SPEED 8
	MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100,  10
    WAIT

	SPEED 8
	MOVE G6B,100,  150, 150, 100, 100, 100
    MOVE G6C,100,  150,  150, 100, 100,  10
    WAIT
    
    SPEED 8
	MOVE G6B,180,  150, 150, 100, 100, 100
    MOVE G6C,180,  150,  150, 100, 100,  10
    WAIT
    
    SPEED 8
    MOVE G6A, 91, 131,  40,  66, 110, 100
	MOVE G6D, 91, 131,  40,  66, 110, 100
	WAIT
	
	SPEED 12
	MOVE G6A, 82, 165,  24,  66, 118, 100
	MOVE G6D, 89, 165,  24,  66, 118, 100
	WAIT
	
	SPEED 8
	MOVE G6B,183,  45,  80, 100, 100, 100
    MOVE G6C,186,  40,  90, 100, 100,  30
    WAIT
  
  	SPEED 8
	MOVE G6A, 90, 150,  54,  74, 108, 100
	MOVE G6D, 90, 150,  54,  74, 108, 100
	WAIT
	
	SPEED 8
	MOVE G6A, 90, 130,  74,  92, 108, 100
	MOVE G6D, 90, 130,  74,  92, 108, 100
	WAIT
  
  	SPEED 8
	MOVE G6A, 90, 110,  94,  97, 104, 100
	MOVE G6D, 90, 110,  94,  97, 104, 100
	WAIT
	
	GOSUB �⺻�ڼ�
  
    
    RETURN	

�������:
    GOSUB ���̷�OFF

    SPEED 8
    MOVE G6A,105, 125,  22, 166,  97, 100
    MOVE G6B,190,  11, 101, 100, 100, 101
    MOVE G6C,190,  11, 101, 100, 100, 101
    MOVE G6D,101, 126,  20, 164, 100, 100
    WAIT


    SPEED 4
    MOVE G6A,105, 136, 103, 131,  96, 100
    MOVE G6D,103, 137, 106, 130,  99, 100
    WAIT

    SPEED 3
    MOVE G6A,105, 167, 112,  89, 100, 100
    WAIT

    SPEED 6
    MOVE G6D,103, 102, 183,  93,  99, 100
    WAIT

    SPEED 6
    MOVE G6A,107, 167, 177,  26,  99, 100
    WAIT

    SPEED 6
    MOVE G6D,103,  60, 179, 122,  99, 100
    WAIT

    SPEED 6
    MOVE G6A, 88, 166,  59, 165, 140, 100
    WAIT

    SPEED 6
    MOVE G6A, 95, 128,  96, 167, 137, 100
    WAIT

    SPEED 6
    MOVE G6D,105, 121, 181,  92,  97, 100
    WAIT

    SPEED 6
    MOVE G6D, 97, 155,  62, 166, 131, 100
    WAIT

    SPEED 6
    MOVE G6D, 95, 128,  96, 167, 137, 100
    WAIT

    SPEED 8
    MOVE G6B,180,  11, 101, 100, 100, 101
    MOVE G6C,180,  11, 101, 100, 100, 101
    WAIT

    SPEED 6

    MOVE G6A, 98,  88, 179, 138, 137, 100
    WAIT

    SPEED 6
    MOVE G6D,102, 134, 100, 167,  94, 100
    WAIT

    SPEED 6
    MOVE G6D,106, 102, 133, 167,  95, 100
    WAIT

    SPEED 6
    MOVE G6A, 99,  94, 183, 126, 132, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  94, 183, 130, 104, 100
    WAIT

    SPEED 6
    MOVE G6A,101, 102, 133, 166, 101, 100
    WAIT

    SPEED 6
    MOVE G6D,101, 102, 133, 166, 101, 100
    WAIT

    SPEED 8
    MOVE G6A,101, 166,  33, 167, 101, 100
    MOVE G6D,101, 166,  33, 167, 101, 100
    WAIT

    SPEED 8
    MOVE G6B,160,  11, 101, 100, 100, 101
    MOVE G6C,160,  11, 101, 100, 100, 101
    WAIT


    FOR I = 1 TO 11
        SPEED 8
        MOVE G6B,180,  11, 101, 100, 100, 101
        MOVE G6C,160,  11, 101, 100, 100, 101
        WAIT

        SPEED 8
        MOVE G6B,156,  11, 101, 100, 100, 101
        MOVE G6C,185,  11, 101, 100, 100, 101
        WAIT
    NEXT I

    SPEED 8
    MOVE G6B,180,  11, 101, 100, 100, 101
    MOVE G6C,160,  11, 101, 100, 100, 101
    WAIT




    SPEED 8
    MOVE G6B,160,  11, 101, 100, 100, 101
    WAIT

    SPEED 6

    MOVE G6A, 78, 164,  46, 163, 145, 100
    MOVE G6D, 84, 161,  36, 167, 126, 100
    WAIT

    SPEED 12
    MOVE G6A, 72, 150,  22, 154, 135, 100
    MOVE G6D, 76, 142,  20, 164, 125, 100

    WAIT

    SPEED 10
    MOVE G6A, 87, 158,  42, 126, 114, 100
    MOVE G6D, 84, 137,  44, 143, 125, 100
    WAIT

    SPEED 10

    MOVE G6A, 98, 149,  62, 103, 103, 100
    MOVE G6D, 94, 133,  64, 113, 111, 100
    WAIT

    SPEED 6
    MOVE G6A,107, 122,  77, 108,  94, 100
    MOVE G6B,102,  53, 101, 100, 100, 101
    MOVE G6C,111,  52, 101, 100, 100, 101
    MOVE G6D,101, 120,  74, 114, 104, 100



    SPEED 8
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT


    GOSUB ���̷�ON

    RETURN

������ܳ�����:
    GOSUB ���̷�OFF

    SPEED 4
    MOVE G6A,101, 167,  21, 123,  99, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    MOVE G6D,102, 165,  21, 127,  99, 100
    WAIT

    SPEED 6
    MOVE G6B, 17,  30,  80, 100, 100, 101
    MOVE G6C, 17,  30,  80, 100, 100, 101
    WAIT

    SPEED 4
    MOVE G6A,101, 167,  20,  69,  99, 100
    MOVE G6D,103, 164,  21,  74,  99, 100
    WAIT

    SPEED 6
    MOVE G6D,104,  92,  21, 148,  98, 100
    WAIT

    SPEED 6
    MOVE G6D,104,  30,  58, 171,  98, 100
    WAIT

    SPEED 10
    MOVE G6D,104,  62, 167, 125,  98, 100

    WAIT

    SPEED 10
    MOVE G6D,104,  98, 166,  83,  98, 100
    WAIT

    SPEED 6
    MOVE G6A,102,  82,  20, 152,  99, 100
    WAIT

    SPEED 6
    MOVE G6A, 95,  12, 114, 165, 103, 100
    WAIT

    SPEED 10
    MOVE G6A,101,  90, 119, 146, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,104,  98, 166,  83,  98, 100
    WAIT

    SPEED 10
    MOVE G6A,104,  12, 166,  83,  98, 100
    MOVE G6D,104,  13, 166,  83,  98, 100
    WAIT

    MOVE G6A,104, 167,  23,  83,  98, 100
    MOVE G6D,104, 165,  23,  85,  98, 100
    WAIT

    MOVE G6A,104, 167,  21, 120,  98, 100
    MOVE G6B, 43,  32,  80, 100, 100, 101
    MOVE G6C, 43,  32,  80, 100, 100, 101
    MOVE G6D,104, 167,  21, 120,  98, 100
    WAIT


    MOVE G6B, 99, 111,  10, 100, 100, 102
    MOVE G6C, 99, 111,  10, 100, 100, 102
    WAIT

    MOVE G6B,153,  62,  66, 100, 100, 101
    MOVE G6C,153,  62,  66, 100, 100, 101
    WAIT

    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT	

    GOSUB ���̷�ON

    RETURN





    '**********************************************
    ' �ൿ
    '**********************************************
���ʿ�����_��:
    SPEED 3
    GOSUB �⺻�ڼ�_�߽ɿ�����_��
    DELAY 50
    SPEED 2
    GOSUB �޹ߵ��_��
    DELAY 50
    GOSUB �����ڼ�_��
    DELAY 50
    SPEED 3
    GOSUB �����ڼ�_��_�߽ɿ���_��
    DELAY 50
    GOSUB �⺻�ڼ�
    'ETX 9600,30

    RETURN

�����ʿ�����_��:
    SPEED 3
    GOSUB �⺻�ڼ�_�߽ɿ���_��
    DELAY 50
    SPEED 2
    GOSUB �����ߵ��_��
    DELAY 50
    GOSUB �����ڼ�_��
    DELAY 50
    SPEED 3
    GOSUB �����ڼ�_��_�߽ɿ�����_��
    DELAY 50
    GOSUB �⺻�ڼ�
    'ETX 9600,30

    RETURN

����ȸ��_��:
    SPEED 5
    GOSUB �⺻�ڼ�_�߽ɿ���_��
    DELAY 50
    GOSUB �⺻�ڼ�_�����߶���
    DELAY 50
    SPEED 5
    GOSUB �����ߵ��2_��
    DELAY 50
    GOSUB �����߳��б�_��
    DELAY 50
    SPEED 5
    GOSUB �����߻���_��
    DELAY 50
    GOSUB �⺻�ڼ�
    'ETX 9600,30

    RETURN

������ȸ��_��:
    SPEED 5
    GOSUB �⺻�ڼ�_�߽ɿ�����_��
    DELAY 50
    GOSUB �⺻�ڼ�_�޹߶���
    DELAY 50
    SPEED 5
    GOSUB �޹ߵ��2_��
    DELAY 50
    GOSUB �޹߳��б�_��
    DELAY 50
    SPEED 5
    GOSUB �޹߻���_��
    DELAY 50
    GOSUB �⺻�ڼ�
    'ETX 9600,30

    RETURN



    '**********************************************
    ' ��Ÿ
    '**********************************************

RECEIVE_DATA:
    ERX 9600, RECEIVED_DATA, RECEIVE_DATA
    RETURN

SET_SERVO_SPEED:
    IF SERVO_SPEED = 0 THEN
        HIGHSPEED SETOFF
        SPEED DEFAULT_SPEED
    ELSEIF SERVO_SPEED <= 15 THEN
        HIGHSPEED SETOFF
        SPEED SERVO_SPEED
    ELSEIF SERVO_SPEED <= 45 THEN
        I = SERVO_SPEED / 3
        HIGHSPEED SETON
        SPEED I
    ELSE
        HIGHSPEED SETON
        SPEED 15
    ENDIF
    RETURN

RESET_SERVO_SPEED:
    HIGHSPEED SETOFF
    SPEED DEFAULT_SPEED
    RETURN



���Ͱ�����:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_ID = RECEIVED_DATA

    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_VALUE = RECEIVED_DATA

    SERVO SERVO_ID, SERVO_VALUE
    RETURN


�ӵ�����:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_SPEED = RECEIVED_DATA

    GOSUB SET_SERVO_SPEED
    RETURN


���Ͱ����:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_ID = RECEIVED_DATA

���Ͱ����_LOOP:
        SERVO_VALUE = MOTORIN(SERVO_ID)
        IF SERVO_VALUE = 0 THEN
            	GOTO ���Ͱ����_LOOP
        ENDIF
    ETX 9600, SERVO_VALUE

    RETURN


�ȸӸ���ũ����:
    ' Ư���� ��Ȳ���� ����Ѵ�.
    ' �ٽ� ���͸� ON��Ű�� ���� �����Ͽ� ������ �ʾҴ�.
    ' (ON ��ų �� ���Ͱ� ������ ������ �����δ�.)
    ' �ٽ� ����ϰ�ʹٸ� �κ��� ����Ű�� �ٶ���.
    MOTOROFF G6B
    MOTOROFF G6C
    RETURN



    '******************************************
    '******************************************	

�����2017_�����׽�Ʈ:
    ' ���� �ٸ����̵�
    Ƚ�� = 10
    GOSUB ��������

    ' �������
    Ƚ�� = 4
    GOSUB ������������_����ȭ3
    Ƚ�� = 4
    GOSUB ������������_��ܺε�����
    GOSUB �������
    Ƚ�� = 16
    GOSUB ��������
    GOSUB ������ܳ�����

    '����
    Ƚ�� = 30
    GOSUB ��������

    ' ���
    Ƚ�� = 4
    GOSUB ������������_����ȭ3
    Ƚ�� = 4
    GOSUB ������������_��ܺε�����
    GOSUB ���

    ' �ڳ�
    Ƚ�� = 7
    GOSUB ��������
    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��

    ' ������Ʈ
    Ƚ�� = 16
    GOSUB ��������

    ' ���
    Ƚ�� = 4
    GOSUB ������������_����ȭ3
    Ƚ�� = 4
    GOSUB ������������_��ܺε�����
    GOSUB ��ܿ�����
    Ƚ�� = 23
    GOSUB ��������
    Ƚ�� = 2
    GOSUB ������������_����ȭ3
    GOSUB ��ܳ�����

    ' ����
    Ƚ�� = 12
    GOSUB ��������
    GOSUB ������_����

    ' �ڳ�
    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��
    Ƚ�� = 18
    GOSUB ��������

    ' ����
    Ƚ�� = 4
    GOSUB ������������_����ȭ3
    Ƚ�� = 4
    GOSUB ������������_��ܺε�����
    GOSUB ����������
    Ƚ�� = 4
    GOSUB ��������
    GOSUB ����

    ' ������Ʈ �� ���� �ٸ����̵�
    Ƚ�� = 24
    GOSUB ��������

    RETURN



TEST:
    GOSUB �⺻�ڼ�
	'GOSUB ���̷�OFF
    'GOSUB �Űȱ�����������Ʈ
    '	GOSUB �����2017_�����׽�Ʈ

	Ƚ�� = 10
	'GOSUB ������������_����ȭ3
	GOSUB ��������

    END
    RETURN


MAIN:
    GOTO TEST

    ERX 9600, A, MAIN

    GOSUB RESET_SERVO_SPEED
    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45
    GOTO MAIN

    RETURN


    '*************************************************************
    '                    K E Y  �� ��  1�� �� �� 2017.08.10
    '                                 2�� �� �� 2017.08.13
    '*************************************************************

    '*************************************************************
    '                    �� �� �� ��  K E Y  �� �� ! ! !
    '*************************************************************

KEY1:
    GOSUB SET_SERVO_SPEED
    GOSUB ���Ͱ�����
    ETX  9600, 0
    GOTO MAIN

KEY2:
    GOSUB �ӵ�����
    ETX  9600, 0
    GOTO MAIN

KEY3:
    GOSUB ���Ͱ����
    GOTO MAIN

KEY4:
    GOSUB �ȸӸ���ũ����
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    �� ��   K E Y  �� �� ! ! !
    '*************************************************************

KEY5:
    GOSUB SET_SERVO_SPEED
    GOSUB �⺻�ڼ�
    ETX  9600, 0
    GOTO MAIN

KEY6:
    GOSUB SET_SERVO_SPEED
    GOSUB ���忬���ڼ�
    ETX  9600, 0
    GOTO MAIN

KEY7:
    GOSUB SET_SERVO_SPEED
    GOSUB ������Ȯ���ڼ�
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    �� ��   K E Y  �� �� ! ! !
    '*************************************************************

KEY8:
    GOSUB SET_SERVO_SPEED
    GOSUB �Ӹ�����
    ETX  9600, 0
    GOTO MAIN

KEY9:
    GOSUB SET_SERVO_SPEED
    GOSUB �Ӹ��ٴ�
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    �� ��   K E Y  �� �� ! ! !
    '*************************************************************

KEY10:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ��������
    ETX  9600, 0
    GOTO MAIN

KEY11:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ������������
    ETX  9600, 0
    GOTO MAIN

KEY12:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ª����������1
    ETX  9600, 0
    GOTO MAIN

KEY13:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ª����������2
    ETX  9600, 0
    GOTO MAIN

KEY14:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ª����������3
    ETX  9600, 0
    GOTO MAIN

KEY15:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ��������
    ETX  9600, 0
    GOTO MAIN

KEY16:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ����������������
    ETX  9600, 0
    GOTO MAIN

KEY17:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ������������_����ȭ3
    ETX  9600, 0
    GOTO MAIN

KEY18:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ������������_��ܺε�����
    ETX  9600, 0
    GOTO MAIN

KEY19:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ������������
    ETX  9600, 0
    GOTO MAIN

KEY20:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    Ƚ�� = RECEIVED_DATA

    GOSUB ����
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                  �� �� �� ��   K E Y  �� �� ! ! !
    '*************************************************************

KEY21:
    '    GOSUB ���ʿ�����_��
    GOSUB ���������غ�_���ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY22:
    GOSUB ���ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY23:
    '    GOSUB ���ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY24:
    '    GOSUB �����ʿ�����_��
    GOSUB ���������غ�_�����ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY25:
    GOSUB �����ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY26:
    '    GOSUB �����ʿ�����_��
    ETX  9600, 0
    GOTO MAIN

KEY27:
    '    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��
    ETX  9600, 0
    GOTO MAIN

KEY28:
    '    GOSUB ����ȸ��_��
    GOSUB ����ȸ��_��2
    ETX  9600, 0
    GOTO MAIN

KEY29:
    GOSUB ����ȸ��_��
    ETX  9600, 0
    GOTO MAIN

KEY30:
    '    GOSUB ������ȸ��_��
    GOSUB ������ȸ��_��
    ETX  9600, 0
    GOTO MAIN

KEY31:
    '    GOSUB ������ȸ��_��
    GOSUB ������ȸ��_��2
    ETX  9600, 0
    GOTO MAIN

KEY32:
    GOSUB ������ȸ��_��
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    �� �� ��   K E Y  �� �� ! ! !
    '*************************************************************

KEY33:
    GOSUB �������
    'ȸ�� �� ���� �� �ڸ�
    ETX 9600, 0
    GOTO MAIN

KEY34:
    GOSUB ������ܳ�����
    ETX 9600, 0
    GOTO MAIN	

KEY35:
    GOSUB ���ں���
    ETX 9600, 0
    GOTO MAIN

KEY36:
    GOSUB ���
    ETX 9600, 0
    GOTO MAIN

KEY37:
    GOSUB ��ܿ�����
    ETX 9600, 0
    GOTO MAIN

KEY38:
    'GOSUB �ʷϴٸ�
    ETX 9600, 0
    GOTO MAIN

KEY39:
    GOSUB ��ܳ�����
    ETX 9600, 0
    GOTO MAIN

KEY40:
    'GOSUB ������1
    ETX 9600, 0
    GOTO MAIN

KEY41:
    GOSUB ������_����
    ETX 9600, 0
    GOTO MAIN

KEY42:
    'GOSUB ������������
    ETX 9600, 0
    GOTO MAIN

KEY43:
    GOSUB ����������
    ETX 9600, 0
    GOTO MAIN

KEY44:
    GOSUB ����
    ETX 9600, 0
    GOTO MAIN

KEY45:
    'GOSUB ����ٸ�����Ʈ
    ETX 9600, 0
    GOTO MAIN




    'KEY11:
    '    ERX 9600, ����Ʈ�ȱ�Ƚ��, KEY11
    '    GOSUB ����Ʈ�ȱ�_1
    '    ETX 9600,64
    '    GOTO MAIN
    '
    'KEY12:
    '    GOSUB ����Ʈ�ȱ⿡���⺻����
    '    ETX 9600,64
    '    GOTO MAIN
    '
