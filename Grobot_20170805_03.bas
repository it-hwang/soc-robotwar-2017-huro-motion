'******** 2족 보행로봇 초기 영점 프로그램 ********

DIM I AS BYTE
DIM A AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM SERVO_ID AS BYTE
DIM SERVO_VALUE AS BYTE
DIM MODE AS BYTE
DIM TEMP AS BYTE

DIM 횟수 AS BYTE
DIM 순서 AS BYTE
DIM 보행순서 AS BYTE

DIM 자이로ONOFF AS BYTE


PTP SETON 				'단위그룹별 점대점동작 설정
PTP ALLON				'전체모터 점대점 동작 설정

DIR G6A,1,0,0,1,0,0		'모터0~5번 그룹사용 설정
DIR G6B,1,1,1,1,1,1		'모터6~11번 그룹사용 설정
DIR G6C,0,0,0,0,0,0		'모터12~17번 그룹사용 설정
DIR G6D,0,1,1,0,1,0		'모터18~23번 그룹사용 설정

'************************************************
'ZERO G6A, 99,  95, 102, 104, 102, 100
'ZERO G6B,101, 108, 102, 100, 100, 100
'ZERO G6C,101, 107,  96, 100, 100, 100
'ZERO G6D, 96,  96, 107, 101, 104, 100
'************************************************
'ZERO G6A, 99,  95, 102, 104, 102, 100
'ZERO G6B,105, 112,  93, 100, 100, 100
'ZERO G6C,101, 107,  96, 100, 100, 100
'ZERO G6D, 96,  96, 107, 101, 104, 100
'************************************************
'ZERO G6A, 99,  95, 102, 104, 102, 100
'ZERO G6B,100, 110, 104, 100, 100, 100
'ZERO G6C,101, 110,  96, 100, 100, 100
'ZERO G6D, 96,  96, 107, 101, 104, 100
'************************************************
'ZERO G6A, 99,  95, 102, 104, 102, 100
'ZERO G6B,100, 110, 104, 100, 100, 100
'ZERO G6C,101, 110,  96, 100, 100, 100
'ZERO G6D, 96,  96, 106, 101, 104, 100
'************************************************



'***** 변수 선언*******************************************

'보행순서 = 0
'****초기위치 피드백*****************************

'GETMOTORSET G6A,1,1,1,1,1,0
'GETMOTORSET G6B,1,1,1,0,0,0
'GETMOTORSET G6C,1,1,1,0,0,0
'GETMOTORSET G6D,1,1,1,1,1,0


SPEED 5
GOSUB MOTOR_ON
GOSUB MOTOR_READ

GOSUB 보드연결자세
GOSUB 머리정면

GOSUB 자이로INIT
GOSUB 자이로MID
GOSUB 자이로ON

GOTO MAIN	'시리얼 수신 루틴으로 가기

'************************************************
MOTOR_READ:
    FOR I = 1 TO 15
        b=MOTORIN(2)
    NEXT I
    RETURN
    '************************************************

MOTOR_ON:
    MOTOR G6A				'모터0~7번 그룹사용 설정
    MOTOR G6B				'모터8~15번 그룹사용 설정
    MOTOR G6C				'모터16~23번 그룹사용 설정
    MOTOR G6D				'모터24~31번 그룹사용 설정
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
    '**** 자이로감도 설정 ****
    '***********************************************

자이로INIT:
    GYRODIR G6A, 0, 0, 0, 0,1
    GYRODIR G6D, 1, 0, 0, 0,0

    RETURN
    '***********************************************
자이로MAX:
    GYROSENSE G6A,255 , 255,255,255
    GYROSENSE G6D,255 , 255,255,255

    RETURN
    '***********************************************
자이로MID:
    GYROSENSE G6A, 255, 100,100,100
    GYROSENSE G6D, 255, 100,100,100

    RETURN
    '***********************************************
자이로MIN:
    GYROSENSE G6A, 50, 50,50,50
    GYROSENSE G6D, 50, 50,50,50

    RETURN
    '***********************************************
자이로ST:
    GYROSENSE G6A,100,30,30,30,
    GYROSENSE G6D,100,30,30,30 ,

    RETURN
    '***********************************************
자이로ON:
    GYROSET G6A, 2, 1, 1, 1,
    GYROSET G6D, 2, 1, 1, 1,

    자이로ONOFF = 1
    RETURN
    '***********************************************
자이로OFF:
    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0

    자이로ONOFF = 0
    RETURN
    '************************************************



    '******************************************
    '******************************************	
자세100:
    MOVE G6A,100,  100,  100, 100, 100, 100
    MOVE G6D,100,  100,  100, 100, 100, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT
    RETURN




























    '**********************************************
    ' 머리
    '**********************************************
머리정면:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    , 100	'상하
    WAIT
    RETURN

머리바닥:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    , 10	'상하
    WAIT
    RETURN

머리중앙선:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  25	'상하
    WAIT
    RETURN

머리중앙선2:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  45	'상하
    WAIT
    RETURN

머리왼쪽선:
    MOVE G6B,   ,    ,    ,    ,    ,  21	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  50	'상하
    WAIT
    RETURN

머리오른쪽선:
    MOVE G6B,   ,    ,    ,    ,    , 179	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  50	'상하
    WAIT
    RETURN

머리왼쪽선2:
    MOVE G6B,   ,    ,    ,    ,    ,  10	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  45	'상하
    WAIT
    RETURN

머리오른쪽선2:
    MOVE G6B,   ,    ,    ,    ,    , 190	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  45	'상하
    WAIT
    RETURN

머리장애물_정면:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  70	'상하
    WAIT
    RETURN

머리장애물_왼쪽:
    MOVE G6B,   ,    ,    ,    ,    ,  60	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  70	'상하
    WAIT
    RETURN

머리장애물_오른쪽:
    MOVE G6B,   ,    ,    ,    ,    , 140	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  70	'상하
    WAIT
    RETURN

머리장애물_하단정면:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  50	'상하
    WAIT
    RETURN

머리장애물_골프공정면:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  40	'상하
    WAIT
    RETURN

머리장애물_하단왼쪽:
    MOVE G6B,   ,    ,    ,    ,    ,  60	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  50	'상하
    WAIT
    RETURN

머리장애물_하단오른쪽:
    MOVE G6B,   ,    ,    ,    ,    , 140	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  50	'상하
    WAIT
    RETURN

머리계단선:
    MOVE G6B,   ,    ,    ,    ,    , 100	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  20	'상하
    WAIT
    RETURN



    MOVE G6A,100,  92, 125, 100, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    , 100
    MOVE G6C,100,  30,  80, 100,    , 100
    WAIT

    '**********************************************
    ' 멈춘 자세
    '**********************************************
기본자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    MODE = 0
    'ETX 9600,30
    RETURN

팔벌린기본자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  80,  80, 100,    ,
    MOVE G6C,100,  80,  80, 100,    ,
    WAIT
    MODE = 0
    'ETX 9600,30
    RETURN

보드연결자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C, 70,  30,  80, 100,    ,
    WAIT
    MODE = 0
    'ETX 9600,30
    RETURN

앉은자세:
    MOVE G6A, 100, 170,  21, 123, 100,
    MOVE G6D, 100, 170,  21, 123, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,100
    WAIT
    MODE = 0
    'ETX 9600,30
    RETURN



기본자세_중심왼쪽_약:
    MOVE G6A,106,  95, 120, 100, 94,
    MOVE G6D, 94,  92, 125, 100, 106,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

기본자세_중심오른쪽_약:
    MOVE G6A, 94,  92, 125, 100, 106,
    MOVE G6D,106,  95, 120, 100, 94,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

벌린자세_약:
    MOVE G6A, 97,  92, 125, 100, 103,
    MOVE G6D, 97,  92, 125, 100, 103,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

벌린자세_약_중심왼쪽_약:
    MOVE G6A,102,  95, 120, 100,  97,
    MOVE G6D, 91,  92, 125, 100, 109,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

벌린자세_약_중심오른쪽_약:
    MOVE G6A, 91,  92, 125, 100, 109,
    MOVE G6D,102,  95, 120, 100,  97,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

벌린자세_중:
    MOVE G6A, 95,  92, 125, 100, 105,
    MOVE G6D, 95,  92, 125, 100, 105,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

벌린자세_강:
    MOVE G6A, 90,  92, 125, 100, 110,
    MOVE G6D, 90,  92, 125, 100, 110,
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C,100,  30,  80, 100,    ,
    WAIT
    RETURN

기본자세_왼발떼기:
    MOVE G6A,  78,  71, 155,  88, 114,
    MOVE G6D, 116,  92, 125, 100,  93,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

기본자세_오른발떼기:
    MOVE G6A, 116,  92, 125, 100,  93,
    MOVE G6D,  78,  71, 155,  88, 114,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

왼발들기_약:
    MOVE G6A, 95,  92, 125,  100, 100,
    MOVE G6D,114,  92, 125,  100, 100,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

왼발들기_강:
    MOVE G6A, 90,  90, 125,  100, 90,
    MOVE G6D,111,  90, 125,  100, 120,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  50,  80,  100,    ,
    WAIT
    RETURN

오른발들기_약:
    MOVE G6A,114,  92, 125,  100, 100,
    MOVE G6D, 95,  92, 125,  100, 100,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

오른발들기_강:
    MOVE G6A,111,  90, 125,  100, 120,
    MOVE G6D, 90,  90, 125,  100, 90,
    MOVE G6B,100,  50,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

왼발들기2_약:
    MOVE G6A, 86,  92, 125,  100, 114,
    MOVE G6D,116,  92, 125,  100,  93,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

왼발들기2_중:
    MOVE G6A, 86,  103, 105,  110, 114,
    MOVE G6D,116,  92, 125,  100,  93,
    MOVE G6B,100,  30,  80,  100,    ,
    MOVE G6C,100,  38,  80,  100,    ,
    WAIT
    RETURN

오른발들기2_약:
    MOVE G6A,116,  92, 125,  100,  93,
    MOVE G6D, 86,  92, 125,  100, 114,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

오른발들기2_중:
    MOVE G6A,116,  92, 125,  100,  93,
    MOVE G6D, 86,  103, 105,  110, 114,
    MOVE G6B,100,  38,  80,  100,    ,
    MOVE G6C,100,  30,  80,  100,    ,
    WAIT
    RETURN

왼발내밀기_약:
    MOVE G6A,  86,  61, 141, 116, 114,
    MOVE G6D, 116,  92, 125, 100,  93,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

오른발내밀기_약:
    MOVE G6A, 116,  92, 125, 100,  93,
    MOVE G6D,  86,  61, 141, 116, 114,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

왼발뻗기_약:
    MOVE G6A,  93,  58, 141, 120, 109,
    MOVE G6D, 108,  96, 119, 108,  89,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  38,  80,  ,  ,
    WAIT
    RETURN

오른발뻗기_약:
    MOVE G6A, 108,  96, 119, 108,  89,
    MOVE G6D,  93,  58, 141, 120, 109,
    MOVE G6B, 100,  38,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    RETURN

검은선확인자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,10,  30,  10, 100,    ,
    MOVE G6C,10,  30,  10, 100,    ,
    WAIT
    'ETX 9600,30
    RETURN


    '**********************************************
    ' 움직이는 자세
    '**********************************************
왼쪽옆으로_중:
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

왼쪽옆으로_약2:
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

오른쪽옆으로_중:
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

오른쪽옆으로_약2:
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

오른쪽회전_중:
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

오른쪽회전_중2:
    GOSUB 자이로OFF

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

    GOSUB 자이로ON
    RETURN

오른쪽회전_중3:
    GOSUB 자이로OFF

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

    GOSUB 자이로ON
    RETURN

왼쪽회전_중:
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

왼쪽회전_중2:
    GOSUB 자이로OFF

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

    GOSUB 자이로ON
    RETURN

왼쪽회전_중3:
    GOSUB 자이로OFF

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

    GOSUB 자이로ON
    RETURN

왼쪽회전_강:
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
    GOSUB 기본자세
    DELAY 100
    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_시작_왼쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6A,  96, 87, 132, 98, 110
    MOVE G6D, 104, 92, 126, 100, 94
    MOVE G6B, 100, 30
    MOVE G6C, 100, 30
    WAIT

    SPEED 12'보행속도
    '왼발들기
    MOVE G6A,  92, 116,  95, 109, 114
    MOVE G6D, 112,  94, 126,  97,  94
    MOVE G6B,  90,  30
    MOVE G6C, 110,  40
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_시작_오른쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6D,  96,  87, 132,  98, 108
    MOVE G6A, 104,  92, 126, 100,  94
    MOVE G6C, 100,  30
    MOVE G6B, 100,  30
    WAIT

    SPEED 12'보행속도
    '왼발들기
    MOVE G6D,  92, 116, 95, 109, 114
    MOVE G6A, 112,  94, 126, 97, 94
    MOVE G6C,  90,  30
    MOVE G6B, 110,  40
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_중간_왼쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6A,  87,  60, 143, 117, 114
    MOVE G6D, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6A, 112, 92, 124, 104, 93
    MOVE G6D, 87, 109, 135, 75, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6A, 113,  93, 126,  97,  94
    MOVE G6D,  92, 116,  85, 114, 114
    MOVE G6B, 110
    MOVE G6C,  90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_중간_오른쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6D,  87,  60, 143, 117, 114
    MOVE G6A, 112,  93, 126,  97,  94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6D, 112,  92, 124, 104,  93
    MOVE G6A,  87, 109, 135,  75, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6D, 113,  93, 126,  97,  94
    MOVE G6A,  92, 116,  85, 114, 114
    MOVE G6C, 110
    MOVE G6B,  90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행_중간_왼쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6A,84, 70, 143, 107, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,86, 100, 135, 82, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행_중간_오른쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6D,84, 70, 143, 107, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,86, 100, 135, 82, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행2_중간_왼쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6A,84, 70, 143, 100, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,86, 96, 135, 92, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행2_중간_오른쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6D,84, 70, 143, 100, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,86, 96, 135, 92, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행3_중간_왼쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6A,83, 84, 143, 96, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6A,112, 92, 124, 100, 93
    MOVE G6D,85, 96, 135, 88, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
짧은전진보행3_중간_오른쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6D,83, 84, 143, 96, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6D,112, 92, 124, 100, 93
    MOVE G6A,85, 96, 135, 88, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_중간_왼쪽_빠른:
    HIGHSPEED SETON
    SPEED 5
    '오른발뻣어착지
    MOVE G6A,87, 60, 143, 117, 114
    MOVE G6D,112, 93, 126, 97, 94
    WAIT
    HIGHSPEED SETOFF

    SPEED 5
    '왼발중심이동
    MOVE G6A,112, 92, 124, 104, 93
    MOVE G6D,87, 109, 135, 75, 112
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
    WAIT

    HIGHSPEED SETON
    SPEED 5
    '오른발들기10
    MOVE G6A,113, 93, 126, 97, 94
    MOVE G6D,92, 116, 85, 114, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    HIGHSPEED SETOFF

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_중간_오른쪽_빠른:
    HIGHSPEED SETON
    SPEED 5
    '오른발뻣어착지
    MOVE G6D,87, 60, 143, 117, 114
    MOVE G6A,112, 93, 126, 97, 94
    WAIT
    HIGHSPEED SETOFF

    SPEED 5
    '왼발중심이동
    MOVE G6D,112, 92, 124, 104, 93
    MOVE G6A,87, 109, 135, 75, 112
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
    WAIT

    HIGHSPEED SETON
    SPEED 5
    '오른발들기10
    MOVE G6D,113, 93, 126, 97, 94
    MOVE G6A,92, 116, 85, 114, 114
    MOVE G6C,110
    MOVE G6B,90
    WAIT
    HIGHSPEED SETOFF

    RETURN

    '***********************************************
    ' [현] 2017-08-05 초기 수정
    '***********************************************
전진보행_끝_왼쪽:
    SPEED 10
    '왼발들기10
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
    GOSUB 기본자세

    RETURN

전진보행_끝_오른쪽:
    SPEED 10
    '왼발들기10
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
    GOSUB 기본자세

    RETURN
    
    
''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    
    
    
    
    
    
    
    

후진보행_시작_왼쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6A, 96, 87, 132, 98, 110
    MOVE G6D,104, 92, 126, 100, 94
    MOVE G6B,100,20
    MOVE G6C,100,20
    WAIT

    SPEED 30'보행속도
    '왼발들기
    MOVE G6A, 92, 116, 95, 112, 114
    MOVE G6D,112, 90, 126, 100, 94
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    RETURN

후진보행_시작_오른쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6D, 96, 87, 132, 98, 110
    MOVE G6A,104, 92, 126, 100, 94
    MOVE G6C,100,20
    MOVE G6B,100,20
    WAIT

    SPEED 30'보행속도
    '왼발들기
    MOVE G6D, 92, 116, 95, 112, 114
    MOVE G6A,112, 90, 126, 100, 94
    MOVE G6C,90
    MOVE G6B,110
    WAIT

    RETURN

후진보행_중간_왼쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6A,  84, 106, 149,  58, 117,
    MOVE G6D,112, 93, 126, 100, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6D,87, 60, 143, 120, 114
    MOVE G6A,112, 93, 126, 100, 94
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6D, 92, 116, 95, 112, 114
    MOVE G6A,112, 90, 126, 100, 94
    MOVE G6C,90
    MOVE G6B,110
    WAIT

    RETURN

후진보행_중간_오른쪽:
    SPEED 10
    '오른발뻣어착지
    MOVE G6D,  84, 106, 149,  58, 117,
    MOVE G6A,112, 93, 126, 100, 94
    WAIT

    SPEED 4
    '왼발중심이동
    MOVE G6A,87, 60, 143, 120, 114
    MOVE G6D,112, 93, 126, 100, 94
    WAIT

    SPEED 10
    '오른발들기10
    MOVE G6A, 92, 116, 95, 112, 114
    MOVE G6D,112, 90, 126, 100, 94
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    RETURN

후진보행_끝_왼쪽:
    SPEED 10
    '왼발들기10
    MOVE G6A, 92, 116, 85, 117, 114
    MOVE G6D, 113, 93, 126, 100, 94
    MOVE G6B, 90
    MOVE G6C,110
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

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB 기본자세

    RETURN

후진보행_끝_오른쪽:
    SPEED 10
    '왼발들기10
    MOVE G6D, 92, 116, 85, 117, 114
    MOVE G6A, 113, 93, 126, 100, 94
    MOVE G6C, 90
    MOVE G6B,110
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

    GOSUB Leg_motor_mode2
    'DELAY 300
    GOSUB 기본자세

    RETURN

전진보행_1:
    GOSUB 전진보행_시작_왼쪽
    GOSUB 전진보행_중간_왼쪽
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    RETURN

전진보행_2:
    GOSUB 전진보행_시작_왼쪽
    GOSUB 전진보행_중간_왼쪽
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_중간_왼쪽
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    RETURN

후진보행_1:
    GOSUB 후진보행_시작_왼쪽
    GOSUB 후진보행_중간_왼쪽
    GOSUB 후진보행_중간_오른쪽
    GOSUB 후진보행_끝_왼쪽
    RETURN

빠른전진보행_1:
    GOSUB 전진보행_시작_왼쪽
    GOSUB 전진보행_중간_왼쪽_빠른
    GOSUB 전진보행_중간_오른쪽_빠른
    GOSUB 전진보행_끝_왼쪽
    RETURN

기어가기_준비:
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

기어가기_시작_오른쪽:
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

기어가기_중간_왼쪽:
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

기어가기_중간_오른쪽:
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

기어가기_끝_왼쪽:
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

전진종종걸음_계단부딪히기:
    TEMP = 0

    SPEED 8


    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  90, 101
        MOVE G6D,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_계단부딪히기_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  90, 101
        MOVE G6A,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_계단부딪히기_2
    ENDIF


    '**********************
전진종종걸음_계단부딪히기_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 전진종종걸음_계단부딪히기_멈춤
    ENDIF
    GOTO 전진종종걸음_계단부딪히기_2
    '*********************************
전진종종걸음_계단부딪히기_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 전진종종걸음_계단부딪히기_멈춤
    ENDIF
    GOTO 전진종종걸음_계단부딪히기_1
    '******************************************
전진종종걸음_계단부딪히기_멈춤:
    IF 순서 = 1 THEN
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


전진종종걸음:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  90, 101
        MOVE G6D,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  90, 101
        MOVE G6A,101,  77, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_2
    ENDIF
    '**************************************
전진종종걸음_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 전진종종걸음_멈춤
    ENDIF
    GOTO 전진종종걸음_2
    '*********************************
전진종종걸음_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 전진종종걸음_멈춤
    ENDIF
    GOTO 전진종종걸음_1
    '******************************************
전진종종걸음_멈춤:
    IF 순서 = 1 THEN
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

전진종종걸음_안정화:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  77, 145,  90, 101
        MOVE G6D,101,  78, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  77, 145,  90, 101
        MOVE G6A,101,  78, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화_2
    ENDIF
    '**************************************
전진종종걸음_안정화_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 전진종종걸음_안정화_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화_2
    '*********************************
전진종종걸음_안정화_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 전진종종걸음_안정화_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화_1
    '******************************************
전진종종걸음_안정화_멈춤:
    IF 순서 = 1 THEN
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

전진종종걸음_안정화2:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  78, 145,  90, 101
        MOVE G6D,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화2_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  78, 145,  90, 101
        MOVE G6A,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화2_2
    ENDIF
    '**************************************
전진종종걸음_안정화2_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 전진종종걸음_안정화2_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화2_2
    '*********************************
전진종종걸음_안정화2_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 전진종종걸음_안정화2_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화2_1
    '******************************************
전진종종걸음_안정화2_멈춤:
    IF 순서 = 1 THEN
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


전진종종걸음_안정화3:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  78, 145,  90, 101
        MOVE G6D,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화3_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  78, 145,  90, 101
        MOVE G6A,101,  79, 145,  90, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 전진종종걸음_안정화3_2
    ENDIF
    '**************************************
전진종종걸음_안정화3_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 전진종종걸음_안정화3_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화3_2
    '*********************************
전진종종걸음_안정화3_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 전진종종걸음_안정화3_멈춤
    ENDIF
    GOTO 전진종종걸음_안정화3_1
    '******************************************
전진종종걸음_안정화3_멈춤:
    IF 순서 = 1 THEN
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


낮은전진종종걸음:
    TEMP = 0

    'SPEED 12
    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  94, 125,  97, 101
        MOVE G6D,101,  95, 125,  97, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 낮은전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  94, 125,  97, 101
        MOVE G6A,101,  95, 125,  97, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 낮은전진종종걸음_2
    ENDIF
    '**************************************
낮은전진종종걸음_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 낮은전진종종걸음_멈춤
    ENDIF
    GOTO 낮은전진종종걸음_2
    '*********************************
낮은전진종종걸음_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 낮은전진종종걸음_멈춤
    ENDIF
    GOTO 낮은전진종종걸음_1
    '******************************************
낮은전진종종걸음_멈춤:
    IF 순서 = 1 THEN
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


후진종종걸음:
    TEMP = 0

    SPEED 12
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 후진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 후진종종걸음_2
    ENDIF
    '**********************

후진종종걸음_1:
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
    IF TEMP >= 횟수 THEN
        순서 = 0
        GOTO 후진종종걸음_멈춤
    ENDIF

    GOTO 후진종종걸음_2
    '*********************************

후진종종걸음_2:
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
    IF TEMP >= 횟수 THEN
        순서 = 1
        GOTO 후진종종걸음_멈춤
    ENDIF

    GOTO 후진종종걸음_1
    '*************************************
후진종종걸음_멈춤:
    IF 순서 = 0 THEN
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


계단오르기2: 'stair walk
    GOSUB 자이로OFF
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
    GOSUB 자이로ON

    RETURN


계단오르기: 'stair walk
    GOSUB 자이로OFF
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

    SPEED 6
    MOVE G6A,90, 40, 130, 150, 114,
    MOVE G6D,113,90, 135,  90,  90
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
    GOSUB 자이로ON

    RETURN

계단내리기: 'stair down
    GOSUB 자이로OFF
    GOSUB All_motor_mode3

    SPEED 4 '다리 내릴때
    MOVE G6C,100,80
    MOVE G6D, 87,  71, 152,  91, 110
    MOVE G6A,103,  76, 145,  93,  94
    MOVE G6B,100,40
    WAIT

    SPEED 7
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  76, 145,  93,  90
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 7
    MOVE G6D,  90, 30, 155, 150, 120,
    MOVE G6A,113,  65, 155,  90,  90
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6D,  90, 30, 175, 150, 114,
    MOVE G6A,113,  115, 65,  140,  90
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
    GOSUB 기본자세

    GOSUB All_motor_Reset
    GOSUB 자이로ON

    RETURN


옆구르기준비:

    MOVE G6A,100,  90, 125, 100, 100
    MOVE G6D,100,  90, 125, 100, 100
    MOVE G6B,100,  90,  30,    ,    , 100
    MOVE G6C,100,  90,  30,    ,    , 100

    RETURN

옆구르기준비_오른쪽옆으로_약:
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

옆구르기준비_왼쪽옆으로_약:
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

오른쪽구르기:
    GOSUB 자이로OFF
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
    GOSUB 자이로ON

    RETURN

허들:
    GOSUB 자이로OFF
    GOSUB All_motor_mode2
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

    GOSUB All_motor_mode3
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
    GOSUB 자이로ON

    RETURN

세레모니1:
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
    GOSUB 기본자세
    RETURN

골프공_차기:
    GOSUB 자이로OFF
    SPEED 10
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

    MOVE G6A, 116,  92, 125, 100,  91,
    MOVE G6D,  91, 120,  72, 124, 119,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    MOVE G6A, 116,  95, 125, 105,  91,
    MOVE G6D,  91, 120,  72,  61, 119,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    MOVE G6A, 116,  90, 125, 105,  91,
    MOVE G6D,  84,  88, 122, 111, 114,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,

    MOVE G6A, 116,  90, 125, 105,  91,
    MOVE G6D,  89,  46, 159, 134, 115,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    MOVE G6A, 116,  85, 125, 105,  91,
    MOVE G6D,  89,  46, 159, 134, 115,
    MOVE G6B, 100,  60,  80,  ,  ,
    MOVE G6C, 100,  60,  80,  ,  ,
    WAIT

    SPEED 8
    DELAY 200
    GOSUB 자이로ON
    GOSUB 기본자세
    RETURN

짧은전진보행:
    GOSUB 전진보행_시작_오른쪽
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    DELAY 100
    RETURN

짧은전진보행2:
    GOSUB 전진보행_시작_오른쪽
    GOSUB 짧은전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    DELAY 100
    RETURN

짧은전진보행3:
    GOSUB 전진보행_시작_오른쪽
    GOSUB 짧은전진보행2_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    DELAY 100
    RETURN

짧은전진보행4:
    GOSUB 전진보행_시작_오른쪽
    GOSUB 짧은전진보행3_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽
    DELAY 100
    RETURN
  	
  	
  	
  	
빨간계단:
GOSUB 자이로OFF

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

SPEED 6
MOVE G6A,101, 166,  33, 167, 101, 100
MOVE G6D,101, 166,  33, 167, 101, 100
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT


SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT


SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,180,  11, 101, 100, 100, 101
MOVE G6C,160,  11, 101, 100, 100, 101
WAIT

SPEED 8
MOVE G6B,160,  11, 101, 100, 100, 101
MOVE G6C,180,  11, 101, 100, 100, 101
WAIT


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


    GOSUB 자이로ON
    
RETURN
    
빨간계단내리기:
    GOSUB 자이로OFF
    
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
    
    GOSUB 자이로ON
	
  	RETURN
  	
  	
  	


    '**********************************************
    ' 행동
    '**********************************************
왼쪽옆으로_약:
    SPEED 3
    GOSUB 기본자세_중심오른쪽_약
    DELAY 50
    SPEED 2
    GOSUB 왼발들기_약
    DELAY 50
    GOSUB 벌린자세_약
    DELAY 50
    SPEED 3
    GOSUB 벌린자세_약_중심왼쪽_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

오른쪽옆으로_약:
    SPEED 3
    GOSUB 기본자세_중심왼쪽_약
    DELAY 50
    SPEED 2
    GOSUB 오른발들기_약
    DELAY 50
    GOSUB 벌린자세_약
    DELAY 50
    SPEED 3
    GOSUB 벌린자세_약_중심오른쪽_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

왼쪽회전_약:
    SPEED 5
    GOSUB 기본자세_중심왼쪽_약
    DELAY 50
    GOSUB 기본자세_오른발떼기
    DELAY 50
    SPEED 5
    GOSUB 오른발들기2_중
    DELAY 50
    GOSUB 오른발내밀기_약
    DELAY 50
    SPEED 5
    GOSUB 오른발뻗기_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

오른쪽회전_약:
    SPEED 5
    GOSUB 기본자세_중심오른쪽_약
    DELAY 50
    GOSUB 기본자세_왼발떼기
    DELAY 50
    SPEED 5
    GOSUB 왼발들기2_중
    DELAY 50
    GOSUB 왼발내밀기_약
    DELAY 50
    SPEED 5
    GOSUB 왼발뻗기_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

기어가기_통합_빨간터널:
    GOSUB 기어가기_준비
    FOR I = 1 TO 11
        GOSUB 기어가기_중간_왼쪽
        GOSUB 기어가기_중간_오른쪽
    NEXT I
    GOSUB 기어가기_끝_왼쪽

    RETURN

전진보행_빠른_바리케이드:
    GOSUB 전진보행_시작_왼쪽
    GOSUB 전진보행_중간_왼쪽
    FOR I = 1 TO 4
        GOSUB 전진보행_중간_오른쪽_빠른
        GOSUB 전진보행_중간_왼쪽_빠른
    NEXT I
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽

    RETURN

전진보행_빠른_바리케이드_멀리:
    GOSUB 전진보행_시작_왼쪽
    GOSUB 전진보행_중간_왼쪽
    FOR I = 1 TO 6
        GOSUB 전진보행_중간_오른쪽_빠른
        GOSUB 전진보행_중간_왼쪽_빠른
    NEXT I
    GOSUB 전진보행_중간_오른쪽
    GOSUB 전진보행_끝_왼쪽

    RETURN


    '**********************************************
    ' 기타
    '**********************************************

모터값조절:
    ERX 9600,SERVO_ID, 모터값조절
모터값조절2:
    ERX 9600,SERVO_VALUE, 모터값조절2
    SERVO SERVO_ID,SERVO_VALUE
    WAIT
    RETURN


    '******************************************
    '******************************************	
MAIN: '라벨설정햬
    'SPEED 5
    'DELAY 500
    'GOTO MAIN
	GOSUB 자이로OFF
	GOSUB 빨간계단
	'GOSUB 자이로ON

    'GOSUB 전진보행_시작_왼쪽
    'GOSUB 전진보행_중간_왼쪽
    'FOR I = 1 TO 20
     '   GOSUB 전진보행_중간_오른쪽
     '   GOSUB 전진보행_중간_왼쪽
    'NEXT I
    'GOSUB 전진보행_중간_오른쪽
    'GOSUB 전진보행_끝_왼쪽	
	
    
    


    'GOSUB 자이로OFF
    'ETX 9600,48
    'GOSUB 오른쪽옆으로_약2
    'DELAY 500
    'GOSUB 왼쪽회전_중
    'GOTO MAIN
    'GOSUB KEY35
    'GOSUB 전진보행_빠른_바리케이드
    'GOSUB KEY24
    'GOSUB 왼쪽회전_강

    'GOSUB 왼쪽회전_중2
    'GOSUB 오른쪽회전_중2


    'GOSUB 짧은전진보행4
    'DELAY 200
    'GOTO MAIN

    'GOTO KEY41
    'GOTO KEY38

    'DELAY 2000
    'GOTO KEY27

    'GOSUB 왼쪽옆으로_약2
    'GOSUB 골프공_차기

    'GOSUB 앉은자세
    '**** 입력된 A값이 0 이면 MAIN 라벨로 가고
    '**** 1이면 KEY1 라벨, 2이면 key2로... 가는문
MAIN1:
    'GOTO KEY1
    'A=A+1
    'IF A=44 THEN
    'A=0
    ERX 9600,A, MAIN1
    'GOTO 오른쪽턴2


    ON A GOTO MAIN1,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61,KEY62,KEY63,KEY64,KEY65,KEY66,KEY67,KEY68,KEY69,KEY70,KEY71
    'GOTO KEY34
    'DELAY 500

    'GOTO 앉아오른팔뻗기

    GOTO MAIN1
    '*******************************************
    '		MAIN 라벨로 가기
    '*******************************************


KEY1:
    'ETX  9600,1
    SPEED 12
    GOSUB 모터값조절
    SPEED 5
    ETX  9600,64
    GOTO MAIN

KEY2:
    '왼쪽선 확인
    SPEED 12
    GOSUB 검은선확인자세
    GOSUB 머리왼쪽선
    SPEED 5
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY3:
    '오른쪽선 확인
    SPEED 12
    GOSUB 검은선확인자세
    GOSUB 머리오른쪽선
    SPEED 5
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY4:
    'ETX  9600,4
    GOSUB 왼쪽옆으로_중
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY5:
    'ETX  9600,5
    GOSUB 오른쪽옆으로_중
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY6:
    'ETX  9600,6
    GOSUB 왼쪽회전_중
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY7:
    'ETX  9600,7
    GOSUB 오른쪽회전_중
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY8:
    SPEED 12
    GOSUB 기본자세
    ETX  9600,64
    GOTO MAIN

KEY9:
    GOSUB 전진보행_1
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY10:
    ETX  9600,1
KEY10_1:
    ERX 9600,B, KEY10_1
    DELAY B
    ETX  9600,64
    GOTO MAIN

KEY11:
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY12:
    GOSUB 자이로OFF
    '머리 숙이기
    MOVE G6B,   ,    ,    ,    ,    ,  10	'좌우
    MOVE G6C,   ,    ,    ,    ,    ,  25	'상하
    WAIT
    GOSUB 기어가기_통합_빨간터널
    GOSUB 머리장애물_정면
    GOSUB 자이로ON
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY13:
    SPEED 12
    GOSUB 앉은자세
    ETX  9600,64
    GOTO MAIN

KEY14:
    GOSUB 전진보행_빠른_바리케이드
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY15:
    GOSUB 전진보행_빠른_바리케이드_멀리
    ETX  9600,64
    GOTO MAIN

KEY16:
    '90도 회전
    GOSUB 왼쪽회전_강
    GOSUB 왼쪽회전_강
    GOSUB 왼쪽회전_강
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY17:
    '왼쪽선 확인2
    SPEED 12
    GOSUB 검은선확인자세
    GOSUB 머리왼쪽선2
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY18:
    '오른쪽선 확인2
    SPEED 12
    GOSUB 검은선확인자세
    GOSUB 머리오른쪽선2
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY19:
    '장애물 확인 - 정면
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_정면
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY20:
    '장애물 확인 - 왼쪽
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_왼쪽
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY21:
    '장애물 확인 - 오른쪽
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_오른쪽
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY22:
    '중앙선 확인
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리중앙선
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY23:
    '중앙선 확인2
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리중앙선2
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY24:
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 1
    GOSUB 전진종종걸음
    횟수 = 2
    GOSUB 전진종종걸음_계단부딪히기
    GOSUB 기본자세
    DELAY 1000
    ETX  9600,64
    GOTO MAIN

KEY25:
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 3
    GOSUB 전진종종걸음
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY26:
    ' 계단에 붙기
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 5
    GOSUB 전진종종걸음
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY27:
    ' 계단오르기
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    'GOSUB 계단오르기
    GOSUB 계단오르기2
    GOSUB 머리정면
    GOSUB 기본자세
    GOSUB 머리장애물_정면
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY28:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 2
    GOSUB 낮은전진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY29:
    ' 계단내려가기
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    GOSUB 계단내리기
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY30:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 4
    GOSUB 낮은전진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY31:
    SPEED 4
    GOSUB 머리계단선
    ETX  9600,64
    GOTO MAIN

KEY32:
    'ETX  9600,4
    GOSUB 왼쪽옆으로_약2
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY33:
    'ETX  9600,5
    GOSUB 오른쪽옆으로_약2
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY34:
    'ETX  9600,5
    HIGHSPEED SETON
    SPEED 10
    GOSUB 머리바닥
    HIGHSPEED SETOFF
    SPEED 5
    ETX  9600,64
    GOTO MAIN

KEY35:
    SPEED 6
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 55
    GOSUB 낮은전진종종걸음
    GOSUB 기본자세
    DELAY 500
    'GOSUB 세레모니1
    'DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY36:
    SPEED 4
    GOSUB 옆구르기준비
    ETX  9600,64
    GOTO MAIN

KEY37:
    GOSUB 오른쪽구르기
    ETX  9600,64
    GOTO MAIN

KEY38:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 1
    GOSUB 낮은전진종종걸음
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY39:
    GOSUB 후진보행_1
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY40:
    GOSUB 왼쪽옆으로_약2
    GOSUB 왼쪽옆으로_약2
    'GOSUB 왼쪽옆으로_약2
    DELAY 300
    GOSUB 골프공_차기
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY41:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 2
    GOSUB 낮은전진종종걸음
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY42:
    '골프홀 확인 - 정면
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_하단정면
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY43:
    '골프홀 확인 - 왼쪽
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_하단왼쪽
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY44:
    '골프홀 확인 - 오른쪽
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_하단오른쪽
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY45:
    SPEED 12
    GOSUB 기본자세
    GOSUB 머리장애물_하단정면
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN


KEY46:
    GOSUB 옆구르기준비_오른쪽옆으로_약
    DELAY 100
    ETX  9600,64
    GOTO MAIN


KEY47:
    GOSUB 옆구르기준비_왼쪽옆으로_약
    DELAY 100
    ETX  9600,64
    GOTO MAIN

KEY48:
    SPEED 12
    GOSUB 머리장애물_하단정면
    SPEED 5
    DELAY 80
    ETX  9600,64
    GOTO MAIN

KEY49:
    GOSUB 전진보행_2
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY50:
    GOSUB 전진보행_시작_왼쪽
    ETX  9600,64
    GOTO MAIN

KEY51:
    GOSUB 전진보행_중간_왼쪽
    GOSUB 전진보행_중간_오른쪽
    ETX  9600,64
    GOTO MAIN

KEY52:
    GOSUB 전진보행_끝_왼쪽
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY53:
    '골프공 확인 - 정면
    SPEED 12
    GOSUB 머리장애물_골프공정면
    SPEED 5
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY54:
    SPEED 4
    MOVE G6A,95,  76, 145,  90, 101
    MOVE G6D,101,  77, 145,  90, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 5
    GOSUB 후진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY55:
    SPEED 6
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 36
    'GOSUB 전진종종걸음
    GOSUB 낮은전진종종걸음
    GOSUB 기본자세
    DELAY 500
    'GOSUB 세레모니1
    'DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY56:
    GOSUB 팔벌린기본자세
    ETX  9600,64
    GOTO MAIN

KEY57:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 4
    GOSUB 낮은전진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY58:
    GOSUB 허들
    ETX  9600,64
    GOTO MAIN

KEY59:
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 22
    GOSUB 낮은전진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN

KEY60:
    GOSUB 왼쪽회전_중2
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY61:
    GOSUB 오른쪽회전_중2
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY62:
    GOSUB 짧은전진보행
    DELAY 200
    ETX  9600,64
    GOTO MAIN

KEY63:
    GOSUB 짧은전진보행2
    DELAY 200
    ETX  9600,64
    GOTO MAIN

KEY64:
    GOSUB 짧은전진보행3
    DELAY 200
    ETX  9600,64
    GOTO MAIN

KEY65:
    GOSUB 짧은전진보행4
    DELAY 200
    ETX  9600,64
    GOTO MAIN

KEY66:
    SPEED 15
    GOSUB 머리정면
    SPEED 5
    ETX 9600,64
    GOTO MAIN

KEY67:
    GOSUB 왼쪽회전_중3
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY68:
    GOSUB 오른쪽회전_중3
    DELAY 300
    ETX  9600,64
    GOTO MAIN

KEY69:
    '허들 후 벗어나기
    SPEED 4
    MOVE G6A,95,  92, 125,  97, 101
    MOVE G6D,101,  93, 125,  97, 98
    MOVE G6B,100,  35
    MOVE G6C,100,  35
    WAIT
    횟수 = 24 
    GOSUB 낮은전진종종걸음
    SPEED 5
    GOSUB 기본자세
    DELAY 500
    ETX  9600,64
    GOTO MAIN
    
KEY70:
	GOSUB 빨간계단
    DELAY 500
    ETX  9600,64
    GOTO MAIN
    
KEY71:
	GOSUB 빨간계단내리기
    DELAY 500
    ETX  9600,64
    GOTO MAIN

    END

