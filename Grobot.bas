'******** 2족 보행로봇 초기 영점 프로그램 ********

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

DIM 횟수 AS BYTE
DIM 순서 AS BYTE
DIM 보행순서 AS BYTE

DIM 자이로ONOFF AS BYTE

DIM 스마트걷기횟수 AS BYTE
DIM 스마트걷기종료 AS BYTE

PTP SETON 				'단위그룹별 점대점동작 설정
PTP ALLON				'전체모터 점대점 동작 설정

DIR G6A,1,0,0,1,0,0		'모터0~5번 그룹사용 설정
DIR G6B,1,1,1,1,1,1		'모터6~11번 그룹사용 설정
DIR G6C,0,0,0,0,0,0		'모터12~17번 그룹사용 설정
DIR G6D,0,1,1,0,1,0		'모터18~23번 그룹사용 설정

'***** 변수 선언*******************************************
'초기 걷기 설정
스마트걷기종료=0
보행순서 = 0

SERVO_SPEED = DEFAULT_SPEED


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

MOTOR_OFF:
    MOTOROFF G6A				'모터0~7번 그룹사용 해제
    MOTOROFF G6B				'모터8~15번 그룹사용 해제
    MOTOROFF G6C				'모터16~23번 그룹사용 해제
    MOTOROFF G6D				'모터24~31번 그룹사용 해제
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





    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,186,  100,  10, 100,    ,
    MOVE G6C,186,  100,  10, 100,    ,
    WAIT






















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
    RETURN

팔벌린기본자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  80,  80, 100,    ,
    MOVE G6C,100,  80,  80, 100,    ,
    WAIT
    MODE = 0
    RETURN

보드연결자세:
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6B,100,  30,  80, 100,    ,
    MOVE G6C, 70,  30,  80, 100,    ,
    WAIT
    MODE = 0
    RETURN

앉은자세:
    MOVE G6A, 100, 170,  21, 123, 100,
    MOVE G6D, 100, 170,  21, 123, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,100
    WAIT
    MODE = 0
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

왼발내밀기_약2:
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
    MOVE G6A, 100,  92, 125, 100, 100
    MOVE G6D, 100,  92, 125, 100, 100
    MOVE G6B,  10,  40,  20, 100,    ,
    MOVE G6C,  10,  40,  20, 100,    ,
    WAIT
    RETURN


    '**********************************************
    ' 움직이는 자세
    '**********************************************
왼쪽옆으로_중:
    GOSUB 자이로OFF
    GOSUB Leg_motor_mode5
    SPEED 10
    MOVE G6A, 90, 106,  99, 112, 105, 	
    MOVE G6D,100,  92, 125, 100, 107, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 13
    MOVE G6A, 102,  92, 126, 103, 100,
    MOVE G6D,83,  94, 119,  100, 115,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    DELAY 100

    GOSUB 자이로ON

    RETURN

오른쪽옆으로_중:
    GOSUB 자이로OFF
    GOSUB Leg_motor_mode5
    SPEED 10
    MOVE G6A,100,  92, 125, 100, 107, 	
    MOVE G6D, 90, 106,  99, 112, 105, 	
    'MOVE G6B,100,  30, 80
    'MOVE G6C,100,  30, 80
    WAIT

    SPEED 13
    MOVE G6A,83,  94, 119,  100, 115,
    MOVE G6D, 102,  92, 126, 103, 100,
    WAIT

    SPEED 6
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    DELAY 100

    GOSUB 자이로ON

    RETURN


    '**********************************************
    ' 전진 보행
    '**********************************************

전진보행_시작_왼쪽:
    GOSUB Leg_motor_mode3
    SPEED 14
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



짧은전진보행1_중간_왼쪽:
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


짧은전진보행1_중간_오른쪽:
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


빠른전진보행_중간_왼쪽:
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


빠른전진보행_중간_오른쪽:
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


    '**********************************************
    ' 후진 보행
    '**********************************************

후진보행_시작_왼쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6A, 96, 87, 132, 98, 110
    MOVE G6D,104, 92, 126, 100, 94
    MOVE G6B,100,30
    MOVE G6C,100,30
    WAIT

    SPEED 30'보행속도
    '왼발들기
    MOVE G6A, 92, 116, 95, 112, 114
    MOVE G6D,112, 90, 126, 100, 94
    MOVE G6B,90,  30
    MOVE G6C,110, 40
    WAIT

    RETURN

후진보행_시작_오른쪽:
    GOSUB Leg_motor_mode3
    SPEED 4
    '오른쪽기울기
    MOVE G6D, 96, 87, 132, 98, 110
    MOVE G6A,104, 92, 126, 100, 94
    MOVE G6C,100,30
    MOVE G6B,100,30
    WAIT

    SPEED 30'보행속도
    '왼발들기
    MOVE G6D, 92, 116, 95, 112, 114
    MOVE G6A,112, 90, 126, 100, 94
    MOVE G6C,90,  30
    MOVE G6B,110, 40
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
    MOVE G6C,    ,  30
    MOVE G6B,    ,  40
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
    MOVE G6B,    ,  30
    MOVE G6C,    ,  40
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
    GOSUB 기본자세

    RETURN

후진보행_끝_오른쪽:
    SPEED 10
    '왼발들기10
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
    GOSUB 기본자세

    RETURN

달리기_32_시작_왼쪽:
    '준비
    MOVE G6A, 95, 92, 125, 100, 101
    MOVE G6D, 101, 93, 125, 100, 98
    WAIT
    '왼발 들기
    MOVE G6A, 95, 96, 100, 127, 104
    MOVE G6D, 107, 93, 126, 98, 102
    MOVE G6B, 80
    MOVE G6C, 120
    WAIT

    RETURN

달리기_32_반복_왼쪽_1:
    MOVE G6A, 95, 91, 102, 127, 104
    MOVE G6D, 106, 94, 126, 95, 100
    WAIT

    MOVE G6A, 103, 84, 125, 110, 100
    MOVE G6D, 95, 102, 140, 75, 102
    WAIT

    RETURN

달리기_32_반복_왼쪽_2:
    MOVE G6D, 95, 111, 80, 127, 104
    MOVE G6A, 105, 93, 126, 98, 102
    MOVE G6C, 80
    MOVE G6B, 120
    WAIT

    RETURN

달리기_32_반복_왼쪽_2_끝:
    MOVE G6D, 90, 109, 95, 107, 104
    MOVE G6A, 104, 90, 125, 98, 102
    MOVE G6C, 100
    MOVE G6B, 100
    WAIT

    GOSUB 기본자세

    RETURN

달리기_32_시작_오른쪽:
    '준비
    MOVE G6D, 95, 92, 125, 100, 101
    MOVE G6A, 101, 93, 125, 100, 98
    WAIT
    '오른발 들기
    MOVE G6D, 95, 96, 100, 127, 104
    MOVE G6A, 107, 93, 126, 98, 102
    MOVE G6C, 80
    MOVE G6B, 120
    WAIT

    RETURN

달리기_32_반복_오른쪽_1:
    MOVE G6D, 95, 91, 102, 127, 104
    MOVE G6A, 106, 94, 126, 95, 100
    WAIT

    MOVE G6D, 103, 84, 125, 110, 100
    MOVE G6A, 95, 102, 140, 75, 102
    WAIT

    RETURN

달리기_32_반복_오른쪽_2:
    MOVE G6A, 95, 111, 80, 127, 104
    MOVE G6D, 105, 93, 126, 98, 102
    MOVE G6B, 80
    MOVE G6C, 120
    WAIT

    RETURN

달리기_32_반복_오른쪽_2_끝:
    MOVE G6A, 90, 109, 95, 107, 104
    MOVE G6D, 104, 90, 125, 98, 102
    MOVE G6B, 100
    MOVE G6C, 100
    WAIT

    GOSUB 기본자세

    RETURN


달리기_3_반복_왼쪽:
    MOVE G6A, 101, 85, 120, 111, 101
    MOVE G6D, 104, 92, 126, 100, 102
    MOVE G6B, 85
    MOVE G6C, 115
    WAIT

    RETURN

달리기_3_반복_오른쪽:
    MOVE G6D, 101, 85, 120, 111, 101
    MOVE G6A, 104, 92, 126, 100, 102
    MOVE G6B, 85
    MOVE G6C, 115
    WAIT

    RETURN
    ''''''''''''''''''''''''''''''''''''''''''''''''''''

전진보행:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 전진보행_시작_왼쪽
    ELSE
        GOSUB 전진보행_시작_오른쪽
    ENDIF

    I = 횟수
전진보행_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 전진보행_중간_왼쪽
        ELSE
            GOSUB 전진보행_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 전진보행_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 전진보행_끝_왼쪽
    ELSE
        GOSUB 전진보행_끝_오른쪽
    ENDIF

    RETURN


빠른전진보행:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 전진보행_시작_왼쪽
    ELSE
        GOSUB 전진보행_시작_오른쪽
    ENDIF

    I = 횟수
빠른전진보행_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 빠른전진보행_중간_왼쪽
        ELSE
            GOSUB 빠른전진보행_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 빠른전진보행_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 전진보행_끝_왼쪽
    ELSE
        GOSUB 전진보행_끝_오른쪽
    ENDIF

    RETURN


짧은전진보행1:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 전진보행_시작_왼쪽
    ELSE
        GOSUB 전진보행_시작_오른쪽
    ENDIF

    I = 횟수
짧은전진보행1_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 짧은전진보행1_중간_왼쪽
        ELSE
            GOSUB 짧은전진보행1_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 짧은전진보행1_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 전진보행_끝_왼쪽
    ELSE
        GOSUB 전진보행_끝_오른쪽
    ENDIF

    RETURN


짧은전진보행2:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 전진보행_시작_왼쪽
    ELSE
        GOSUB 전진보행_시작_오른쪽
    ENDIF

    I = 횟수
짧은전진보행2_LOOP:
    IF 횟수 > 0 THEN
        IF A = 0 THEN
            GOSUB 짧은전진보행2_중간_왼쪽
        ELSE
            GOSUB 짧은전진보행2_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 짧은전진보행2_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 전진보행_끝_왼쪽
    ELSE
        GOSUB 전진보행_끝_오른쪽
    ENDIF

    RETURN


짧은전진보행3:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 전진보행_시작_왼쪽
    ELSE
        GOSUB 전진보행_시작_오른쪽
    ENDIF

    I = 횟수
짧은전진보행3_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 짧은전진보행3_중간_왼쪽
        ELSE
            GOSUB 짧은전진보행3_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 짧은전진보행3_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 전진보행_끝_왼쪽
    ELSE
        GOSUB 전진보행_끝_오른쪽
    ENDIF

    RETURN


후진보행:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    IF A = 0 THEN
        GOSUB 후진보행_시작_왼쪽
    ELSE
        GOSUB 후진보행_시작_오른쪽
    ENDIF

    I = 횟수
후진보행_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 후진보행_중간_왼쪽
        ELSE
            GOSUB 후진보행_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 후진보행_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 후진보행_끝_왼쪽
    ELSE
        GOSUB 후진보행_끝_오른쪽
    ENDIF

    RETURN

달리기_32: '32밀리미터/보
    GOSUB 자이로OFF
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode4
    DELAY 50
    
    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    HIGHSPEED SETON
    SPEED 5
    IF A = 0 THEN
        GOSUB 달리기_32_시작_왼쪽
    ELSE
        GOSUB 달리기_32_시작_오른쪽
    ENDIF

    SPEED 12
    B = 횟수 - 1
    FOR I = 1 TO B
        IF A = 0 THEN
            GOSUB 달리기_32_반복_왼쪽_1
            GOSUB 달리기_32_반복_왼쪽_2
        ELSE
            GOSUB 달리기_32_반복_오른쪽_1
            GOSUB 달리기_32_반복_오른쪽_2
        ENDIF
        A = 1 - A
    NEXT I

    SPEED 8
    IF A = 0 THEN
        GOSUB 달리기_32_반복_왼쪽_1
        GOSUB 달리기_32_반복_왼쪽_2_끝
    ELSE
        GOSUB 달리기_32_반복_오른쪽_1
        GOSUB 달리기_32_반복_오른쪽_2_끝
    ENDIF

    HIGHSPEED SETOFF
    GOSUB 자이로ON

    RETURN

달리기_3: '3밀리미터/보
    GOSUB 자이로OFF
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    DELAY 50

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽발이 들어올려진 상태
    ' A = 1: 오른쪽 발이 들어올려진 상태
    HIGHSPEED SETON
    SPEED 3
    GOSUB 기본자세

    B = 횟수 - 1
    FOR I = 1 TO B
        IF A = 0 THEN
            GOSUB 달리기_3_반복_왼쪽
        ELSE
            GOSUB 달리기_3_반복_오른쪽
        ENDIF
        A = 1 - A
    NEXT I

    GOSUB 기본자세

    HIGHSPEED SETOFF
    GOSUB 자이로ON

    RETURN


    ''''''''''''''''''''''''''''''''''''''''''''''''''''

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

기어가기_끝_오른쪽:
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

기어가기:
    HIGHSPEED SETOFF

    ' A = 0~1 무작위 수
    A = RND
    A = A % 2

    ' A = 0: 왼쪽팔이 앞선 상태
    ' A = 1: 오른쪽 팔이 앞선 상태
    GOSUB 기어가기_준비

    I = 횟수
기어가기_LOOP:
    IF I > 0 THEN
        IF A = 0 THEN
            GOSUB 기어가기_중간_왼쪽
        ELSE
            GOSUB 기어가기_중간_오른쪽
        ENDIF
        A = 1 - A
        I = I - 1

        GOTO 기어가기_LOOP
    ENDIF

    IF A = 0 THEN
        GOSUB 기어가기_끝_왼쪽
    ELSE
        GOSUB 기어가기_끝_오른쪽
    ENDIF

    RETURN



    ''''''''''''''''''''''''''''''''''''''''''''''''''''

전진종종걸음_계단부딪히기:
    TEMP = 0

    SPEED 8
    HIGHSPEED SETOFF


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


함정오르기:

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
    GOSUB 자이로ON

    GOSUB 기본자세

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
    MOVE G6B,100,45
    MOVE G6C,100,45
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
    MOVE G6D,72,  90, 165,  50, 103
    MOVE G6B,160,85
    MOVE G6C,160,35
    WAIT
    DELAY 1500
    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 2
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,100,  90, 165,  60, 109
    WAIT
    DELAY 500

    SPEED 4
    '주행시 116 -> 115
    MOVE G6A, 115,  90, 100, 150,  95,
    MOVE G6D, 100, 140, 160,  60, 109
    WAIT

    SPEED 12
    MOVE G6A, 116, 90, 100, 150,95,
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

계단오르기2: 'stair walk
    GOSUB 자이로OFF
    GOSUB Leg_motor_mode3
    SPEED 14
    '오른쪽기울기
    MOVE G6A,  96, 87, 132, 98, 110
    MOVE G6D, 104, 92, 126, 100, 94
    MOVE G6B, 100, 30
    MOVE G6C, 100, 30
    WAIT

    SPEED 12'보행속도
    '왼발들기
    MOVE G6A,  92, 116,  95, 109, 114
    MOVE G6D, 116,  94, 126,  97,  94
    MOVE G6B,  90,  40
    MOVE G6C, 110,  50
    WAIT

    '왼발들기
    MOVE G6A, 81, 138,  24, 154, 114
    MOVE G6D, 113, 88, 130,  95,  94
    WAIT

    HIGHSPEED SETON

    SPEED 15
    '오른발뻣어착지
    MOVE G6A, 76,  86, 157, , 114
    WAIT

    HIGHSPEED SETOFF

    '****************************

    SPEED 15
    '오른발뻣어착지
    MOVE G6A, 81,  11, 177, 128, 114
    MOVE G6D,108, 105, 126,  84,  98
    WAIT


    MOVE G6A, 81,  30, 137, 145, 114,
    WAIT


    MOVE G6A,103,  69,  99, 165, 113,
    MOVE G6D, 90,  82, 144,  88,  90,
    MOVE G6C,128,  69,  100, 100, 100,
    MOVE G6B,111,  51,  81, 100, 100,
    WAIT

    'SPEED 12
    'MOVE G6A,107,  82,  102, 155, 113,
    'MOVE G6D,108, 100,  98, 100,  90,
    'MOVE G6B,128,  69,  81, 100, 100,
    'MOVE G6C,111,  51,  81, 100, 100,
    'WAIT

    SPEED 12
    MOVE G6A,107,  82,  102, 155, 113,
    MOVE G6D,108, 120,  78, 100,  90,
    MOVE G6B,128,  69,  100, 100, 100,
    MOVE G6C,111,  51,  81, 100, 100,
    WAIT

    GOSUB 자이로ON

    SPEED 10
    MOVE G6A,107,  82,  102, 145, 113,
    MOVE G6D, 88,  86, 100, 143, 101,
    WAIT

    SPEED 8
    MOVE G6A, 99,  85, 102, 135, 110,
    MOVE G6D, 94,  77, 116, 128,  97,
    WAIT

    GOSUB 기본자세

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
    GOSUB 기본자세

    GOSUB All_motor_Reset
    GOSUB 자이로ON

    RETURN

계단내리기2:
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

    MOVE G6A, 114,  88, 126, 92, 90
    MOVE G6D, 92,  93,  53, 165, 127,
    MOVE G6B,111,  45,  86, 100, 100,
    MOVE G6C, 91,  73,  95, 100, 100,
    WAIT

    MOVE G6A,108, 98, 154,  50,  90, 	
    MOVE G6D, 82,  70,  81, 163, 120, 100
    WAIT

    WAIT
    HIGHSPEED SETON

    SPEED 8

    'MOVE G6A,107, 128, 135,  50,  94,
    MOVE G6A,104, 103, 154,  40,  94,
    MOVE G6D, 98,  12, 148, 150, 112,
    WAIT


    MOVE G6D,104,  36, 145, 139, 110,
    WAIT

    SPEED 14

    MOVE G6C,111,  45,  86, 100, 100,
    MOVE G6B, 91,  73,  95, 100, 100,
    MOVE G6A,103,  94, 106,  81,  89,
    MOVE G6D,104,  71, 123, 147, 104,
    'MOVE G6D,112,  71, 123, 147, 104,
    WAIT

    'GOSUB 자이로ON

    MOVE G6A,100, 120,  47, 134,  100,
    MOVE G6D,106,  71, 123, 147, 104,
    'MOVE G6D,114,  71, 123, 147, 104,
    WAIT

    HIGHSPEED SETOFF

    GOSUB 자이로ON

    SPEED 10
    MOVE G6D,107,  82,  102, 145, 113,
    MOVE G6A, 88,  86, 100, 143, 101,
    WAIT

    SPEED 8
    MOVE G6D, 99,  85, 102, 135, 110,
    MOVE G6A, 94,  77, 116, 128,  97,
    WAIT

    GOSUB 기본자세


    GOSUB All_motor_Reset

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

    DELAY 100

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

    DELAY 100

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
    SPEED 15
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

    SPEED 15
    MOVE G6A, 100,  80, 175,  84,  98,
    MOVE G6D, 100,  80, 175,  84,  98,
    MOVE G6B, 190,  30,  80,  ,  ,
    MOVE G6C, 190,  30,  80,  ,  ,
    WAIT

    SPEED 8
    MOVE G6D, 110, 101,  80,  10, 123,  ,
    WAIT

    SPEED 8
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    MOVE G6A, 110, 101,  80,  10, 123,

    WAIT

    SPEED 8
    MOVE G6A, 110, 101,  80,  10, 133,  ,
    MOVE G6D, 110, 101,  80,  10, 133,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT
    DELAY 300

    HIGHSPEED SETON
    SPEED 5

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

    MOVE G6A, 120, 10,  110,  100, 170,  ,
    MOVE G6D, 120, 10,  110,  100, 170,  ,
    MOVE G6B, 190,  100,  80,  ,  , 100
    MOVE G6C, 190,  100,  80,  ,  , 110
    WAIT

    MOVE G6A, 120, 20,  110,  100, 170,  ,
    MOVE G6D, 120, 20,  110,  100, 170,  ,
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
    MOVE G6B, 190, 100,  100,  ,  ,
    MOVE G6C, 190, 100,  100,  ,  ,
    WAIT

    MOVE G6A, 103, 170, 144,  91, 116,
    MOVE G6D, 103, 170, 144,  91, 116,
    MOVE G6B, 100, 190,  100,  ,  ,
    MOVE G6C, 100, 184,  100,  ,  ,
    WAIT
    GOSUB 자이로ON

    MOVE G6A, 100, 150,  86, 160, 142,
    MOVE G6D, 100, 150,  86, 160, 142,
    MOVE G6B, 50, 190,  100,  ,  ,
    MOVE G6C, 50, 184,  100,  ,  ,
    WAIT

    'MOVE G6A,  73, 167,  42, 162, 142,
    'MOVE G6D,  73, 167,  42, 162, 142,

    MOVE G6D, 73, 165,  68, 155, 170, 100
    MOVE G6A, 73, 165,  68, 155, 170, 100
    MOVE G6B,  10, 190,  100,  ,  ,
    MOVE G6C,  10, 184,  100,  ,  ,
    WAIT
    DELAY 600

    HIGHSPEED SETOFF
    GOSUB All_motor_mode3
    SPEED 8

    MOVE G6A, 58, 166,  68, 155, 172, 100
    MOVE G6D, 58, 166,  68, 155, 172, 100
    WAIT

    MOVE G6A, 58, 164,  32, 156, 149, 100
    MOVE G6D, 58, 164,  32, 156, 149, 100
    WAIT

    MOVE G6A, 54, 163,  26, 131, 150, 100
    MOVE G6D, 54, 163,  26, 131, 150, 100
    WAIT

    MOVE G6A,  52, 170,  23, 115, 144,
    MOVE G6D,  52, 170,  23, 115, 144,
    MOVE G6B, 172,  22,  71,  ,  ,
    MOVE G6C, 172,  22,  71,  ,  ,
    WAIT

    MOVE G6A,  94, 170,  23, 115, 104,
    MOVE G6D,  94, 170,  23, 115, 104,
    MOVE G6B, 159,  22,  71,  ,  ,
    MOVE G6C, 159,  22,  71,  ,  ,
    WAIT

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

    GOSUB 기본자세
    GOSUB 자이로ON

    RETURN

함정:

    GOSUB 자이로OFF
    GOSUB 기본자세

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
    MOVE G6B,190,  40,  90, 100, 100, 100
    MOVE G6C,190,  40,  90, 100, 100,  30
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

    GOSUB 기본자세
    RETURN


지뢰보행:

    GOSUB 자이로OFF

    SPEED 8
    MOVE G6A, 90,  92, 125, 100, 108, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    DELAY 500


    FOR I = 1 TO 20
        SPEED 8
        MOVE G6A, 90,  92, 125, 125, 110, 100
        MOVE G6D, 90,  92, 125, 100, 110, 100
        WAIT

        SPEED 8
        MOVE G6A, 90,  92, 125, 100, 110, 100
        MOVE G6D, 90,  92, 125, 125, 110, 100
        WAIT
    NEXT I

    MOVE G6A, 90,  92, 125, 100, 110, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    GOSUB 기본자세

    GOSUB 자이로ON

    RETURN

지뢰보행2:

    GOSUB 자이로OFF

    'GOSUB Leg_motor_mode3

    SPEED 8
    MOVE G6A, 90,  92, 125, 100, 108, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    DELAY 500

    HIGHSPEED SETON
    SPEED 5

    FOR I = 1 TO 20
        MOVE G6A, 90,  92, 125, 115, 110, 100
        MOVE G6D, 90,  92, 125, 100, 110, 100
        WAIT

        MOVE G6A, 90,  92, 125, 100, 110, 100
        MOVE G6D, 90,  92, 125, 115, 110, 100
        WAIT
    NEXT I

    MOVE G6A, 90,  92, 125, 100, 110, 100
    MOVE G6D, 90,  92, 125, 100, 110, 100
    WAIT

    GOSUB 기본자세

    GOSUB 자이로ON

    RETURN


빨간계단_구르기:
    GOSUB 자이로OFF
    HIGHSPEED SETON
    SPEED 10

    MOVE G6B,150,  40,  90, 100, 100, 100
    MOVE G6C,150,  40,  90, 100, 100,  10
    WAIT

    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 102,  97, 133,  97, 100
    MOVE G6D,100, 102,  97, 133,  97, 100
    WAIT

    MOVE G6A,100, 102,  97, 163,  97, 100
    MOVE G6D,100, 102,  97, 163,  97, 100
    WAIT

    'MOVE G6A,102,  60, 158, 130,  97, 100
    'MOVE G6D,102,  60, 158, 130,  97, 100
    'WAIT

    HIGHSPEED SETON
    SPEED 10

    DELAY 200

    MOVE G6A, 100, 50,  120, 10, 100, 100
    WAIT

    MOVE G6D, 100, 50,  120, 12, 100, 100
    WAIT

    MOVE G6B,187,  40,  80, 100, 100, 100
    MOVE G6C,187,  40,  80, 100, 100,  30
    WAIT

    DELAY 500

    MOVE G6A,111,  26, 150,  14, 175, 100
    MOVE G6D,111,  16, 160,  14, 175, 100
    MOVE G6C,186,  40,  90, , , 10
    MOVE G6B,186,  40,  90,
    WAIT

    DELAY 500

    MOVE G6A,100,  26, 166,  14, 110, 100
    MOVE G6D,100,  26, 166,  14, 110, 100
    WAIT
    '*************************************************
    '수정중

    MOVE G6A,103,  20,  71, 130, 115, 100
    MOVE G6D,103,  20,  71, 130, 115, 100
    WAIT

    MOVE G6A,103,  70,  150, 90, 115, 100
    MOVE G6D,103,  70,  150, 90, 115, 100
    WAIT

    MOVE G6B,186,  100,  100, 100, 100, 100
    MOVE G6C,186,  100,  100, 100, 100,  10
    WAIT

    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100,  10
    WAIT

    MOVE G6B,100,  150, 150, 100, 100, 100
    MOVE G6C,100,  150, 150, 100, 100,  10
    WAIT

    HIGHSPEED SETOFF
    SPEED 8

    MOVE G6B,186,  150, 150, 100, 100, 100
    MOVE G6C,186,  150, 150, 100, 100,  10
    MOVE G6A, 81, 125,  51,  52, 169, 100
    MOVE G6D, 81, 125,  51,  52, 169, 100
    WAIT

    MOVE G6A, 61, 129,  64,  52, 162, 100
    MOVE G6D, 61, 129,  64,  52, 162, 100
    WAIT

    MOVE G6A, 62, 140,  69,  60, 137, 100
    MOVE G6D, 62, 140,  69,  60, 137, 100
    WAIT

    HIGHSPEED SETON
    SPEED 10

    MOVE G6B,186,  40,  80, 100, 100, 100
    MOVE G6C,186,  40,  90, 100, 100,  30
    WAIT

    GOSUB 자이로ON
    GOSUB Leg_motor_mode3

    MOVE G6A, 77, 133,  60, 113, 128, 100
    MOVE G6D, 77, 133,  60, 113, 128, 100
    WAIT

    HIGHSPEED SETOFF
    GOSUB 기본자세

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


    GOSUB 자이로ON

    RETURN

빨간계단_내리기:
    GOSUB 자이로OFF
    SPEED 12

    MOVE G6A,101, 167,  21, 123,  99, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    MOVE G6D,102, 165,  21, 127,  99, 100
    WAIT

    SPEED 15

    MOVE G6B, 17,  30,  80, 100, 100, 101
    MOVE G6C, 17,  30,  80, 100, 100, 101
    WAIT

    MOVE G6A,101, 167,  20,  69,  99, 100
    MOVE G6D,103, 164,  21,  74,  99, 100
    WAIT

    HIGHSPEED SETON
    SPEED 8

    MOVE G6D,104,  92,  21, 148,  98, 100
    WAIT

    MOVE G6D,104,  30,  58, 171,  98, 100
    WAIT

    MOVE G6D,104,  62, 167, 125,  98, 100
    WAIT

    MOVE G6D,104,  98, 166,  83,  98, 100
    WAIT

    MOVE G6A,102,  82,  20, 152,  99, 100
    WAIT

    MOVE G6A, 95,  12, 114, 165, 103, 100
    WAIT

    MOVE G6A,101,  90, 119, 146, 105, 100
    WAIT

    MOVE G6A,104,  98, 166,  83,  98, 100
    WAIT

    MOVE G6A,104,  12, 166,  83,  98, 100
    MOVE G6D,104,  13, 166,  83,  98, 100
    WAIT

    HIGHSPEED SETOFF
    SPEED 10

    MOVE G6A,104, 167,  23,  83,  98, 100
    MOVE G6D,104, 165,  23,  85,  98, 100
    WAIT

    GOSUB Leg_motor_mode3

    MOVE G6A,104, 167,  21, 120,  98, 100
    MOVE G6B, 43,  32,  80, 100, 100, 101
    MOVE G6C, 43,  32,  80, 100, 100, 101
    MOVE G6D,104, 167,  21, 120,  98, 100
    WAIT

    GOSUB 기본자세	

    RETURN

    '**********************************************
    ' 측면 보행
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

왼쪽옆으로_약2:
    GOSUB 자이로OFF
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

    DELAY 100

    GOSUB 자이로ON

    RETURN

왼쪽옆으로_약3:
    GOSUB Leg_motor_mode5
    SPEED 3
    GOSUB 기본자세_중심오른쪽_약
    SPEED 5
    GOSUB 벌린자세_약_중심왼쪽_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

왼쪽옆으로_약4:
    SPEED 3
    GOSUB 왼발들기_약

    GOSUB Leg_motor_mode3

    SPEED 8
    MOVE G6A, 90,  92, 125,  100, 115,
    MOVE G6D,100,  92, 125,  100, 100,
    WAIT

    MOVE G6D,105,  92, 125,  100, 115,
    MOVE G6A,100,  92, 125,  100, 100,
    WAIT

    SPEED 3
    GOSUB 오른발들기_약

    GOSUB 기본자세
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

오른쪽옆으로_약2:
    GOSUB 자이로OFF
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

    DELAY 100

    GOSUB 자이로ON

    RETURN

오른쪽옆으로_약3:
    GOSUB Leg_motor_mode5
    SPEED 3
    GOSUB 기본자세_중심왼쪽_약
    SPEED 5
    GOSUB 벌린자세_약_중심오른쪽_약
    DELAY 50
    GOSUB 기본자세
    'ETX 9600,30

    RETURN

오른쪽옆으로_약4:
    SPEED 3
    GOSUB 오른발들기_약

    GOSUB Leg_motor_mode3

    SPEED 8
    MOVE G6D, 90,  92, 125,  100, 115,
    MOVE G6A,100,  92, 125,  100, 100,
    WAIT

    MOVE G6A,105,  92, 125,  100, 115,
    MOVE G6D,100,  92, 125,  100, 100,
    WAIT

    SPEED 3
    GOSUB 왼발들기_약

    GOSUB 기본자세
    RETURN


    '**********************************************
    ' 회전
    '**********************************************

왼쪽회전_4: '4.5도
    GOSUB 자이로OFF

    GOSUB Leg_motor_mode1
    
    SPEED 6
    MOVE G6D, 101, 94, 125, 100, 100
    MOVE G6A, 99, 94, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6D,100,  72
    MOVE G6A,100,  112
    WAIT

    MOVE G6D,100,  87, , 105
    MOVE G6A,100,  97, , 95
    WAIT
    GOSUB Leg_motor_mode3
    DELAY 20

    SPEED 5
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 40
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON

    RETURN


왼쪽회전_6: '6.4도
    GOSUB 자이로OFF
    
    GOSUB Leg_motor_mode1

	SPEED 6
    MOVE G6D, 101, 94, 125, 100, 100
    MOVE G6A, 99, 94, 125, 100, 100
    WAIT

	SPEED 15
    MOVE G6D,100,  72
    MOVE G6A,100,  112
    WAIT

    MOVE G6D,100,  82, , 110
    MOVE G6A,100,  102, , 90
    WAIT
    GOSUB Leg_motor_mode2
    DELAY 70

	SPEED 5
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 100
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON
    
    RETURN
    

왼쪽회전_27: '27.5도
    GOSUB 자이로OFF

    GOSUB Leg_motor_mode1

    SPEED 6
    MOVE G6D, 101, 94, 125, 100, 100
    MOVE G6A, 99, 94, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6D,100,  62
    MOVE G6A,100,  122
    WAIT

    MOVE G6D,100,  72, , 120
    MOVE G6A,100,  112, , 80
    WAIT
    GOSUB Leg_motor_mode2
    DELAY 100

    SPEED 5
    MOVE G6D,100,  92, 125, 100, 100
    MOVE G6A,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 200
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON

    RETURN
    
    
왼쪽회전_30: '30도
    GOSUB 자이로OFF
    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A,95,  132, 125,  60, 105, 100
    MOVE G6D,95,  52, 125,  140, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  132, 125,  60, 105, 100
    MOVE G6D,90,  52, 125,  140, 105, 100
    WAIT

    SPEED 10
    GOSUB 기본자세
    DELAY 350
    GOSUB 자이로ON
    RETURN
    

오른쪽회전_4: '4.5도
    GOSUB 자이로OFF

    GOSUB Leg_motor_mode1
    SPEED 6
    MOVE G6A, 101, 94, 125, 100, 100
    MOVE G6D, 99, 94, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  72
    MOVE G6D,100,  112
    WAIT

    MOVE G6A,100,  87, , 105
    MOVE G6D,100,  97, , 95
    WAIT
    GOSUB Leg_motor_mode3
    DELAY 50

    SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 40
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON

    RETURN
	
	
오른쪽회전_6: '6.4도
    GOSUB 자이로OFF
    
    GOSUB Leg_motor_mode1
    
	SPEED 6
    MOVE G6A, 101, 94, 125, 100, 100
    MOVE G6D, 99, 94, 125, 100, 100
    WAIT

	SPEED 15
    MOVE G6A,100,  72
    MOVE G6D,100,  112
    WAIT

    MOVE G6A,100,  82, , 110
    MOVE G6D,100,  102, , 90
    WAIT
    GOSUB Leg_motor_mode2
    DELAY 70

	SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 100
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON
    
    RETURN
    
    
오른쪽회전_27: '27.5도
    GOSUB 자이로OFF

    GOSUB Leg_motor_mode1
    HIGHSPEED SETOFF
    SPEED 6
    MOVE G6A, 101, 94, 125, 100, 100
    MOVE G6D, 99, 94, 125, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  62
    MOVE G6D,100,  122
    WAIT

    MOVE G6A,100,  72, , 120
    MOVE G6D,100,  112, , 80
    WAIT
    GOSUB Leg_motor_mode2
    DELAY 100

    HIGHSPEED SETOFF
    SPEED 5
    MOVE G6A,100,  92, 125, 100, 100
    MOVE G6D,100,  92, 125, 100, 100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 200
    GOSUB Leg_motor_mode2
    GOSUB 자이로ON

    RETURN
    
    
오른쪽회전_30: '30도
    GOSUB 자이로OFF
    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A,95,  52, 125,  140, 105, 100
    MOVE G6D,95,  132, 125,  60, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  52, 125,  140, 105, 100
    MOVE G6D,90,  132, 125,  60, 105, 100
    WAIT

    SPEED 10
    GOSUB 기본자세
    DELAY 350
    GOSUB 자이로ON
    RETURN


    '**********************************************
    ' 기타
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



모터값조절:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_ID = RECEIVED_DATA

    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_VALUE = RECEIVED_DATA

    SERVO SERVO_ID, SERVO_VALUE
    RETURN


모터값조절_대기:
    MOVE24 ,
    WAIT
    RETURN


속도조절:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_SPEED = RECEIVED_DATA

    GOSUB SET_SERVO_SPEED
    RETURN


모터값얻기:
    ETX 9600, 255
    GOSUB RECEIVE_DATA
    SERVO_ID = RECEIVED_DATA

모터값얻기_LOOP:
    SERVO_VALUE = MOTORIN(SERVO_ID)
    IF SERVO_VALUE = 0 THEN
        GOTO 모터값얻기_LOOP
    ENDIF
    ETX 9600, SERVO_VALUE

    RETURN


팔머리토크해제:
    ' 특수한 상황에만 사용한다.
    ' 다시 모터를 ON시키는 것은 위험하여 만들지 않았다.
    ' (ON 시킬 때 모터가 굉장히 빠르게 움직인다.)
    ' 다시 사용하고싶다면 로봇을 껐다키길 바란다.
    MOTOROFF G6B
    MOTOROFF G6C
    RETURN



    '******************************************
    '******************************************	



TEST:

    GOSUB 기본자세
    'SERVO 17, 40
    'DELAY 1000

    FOR I = 1 TO 12
        'GOSUB 왼쪽회전_약3
        'GOSUB 오른쪽회전_약5
        'GOSUB 오른쪽회전_약3
        'GOSUB 오른쪽회전_약5
        'GOSUB 오른쪽옆으로_약3
        GOSUB 왼쪽옆으로_중
        'GOSUB 오른쪽옆으로_중
        'GOSUB 왼쪽옆으로_약2
    NEXT



    'DELAY 1000

    FOR I = 1 TO 14
     	'GOSUB 왼쪽회전_약5
        'GOSUB 왼쪽회전_약5
        'GOSUB 왼쪽회전_약3
        'GOSUB 왼쪽회전_약4
        'GOSUB 오른쪽회전_약3
        'GOSUB 왼쪽옆으로_중
        GOSUB 오른쪽옆으로_중
        'GOSUB 오른쪽옆으로_약2
        'GOSUB 왼쪽옆으로_약3
    NEXT


    END
    RETURN


MAIN:
    'GOTO TEST

    ERX 9600, A, MAIN

    GOSUB RESET_SERVO_SPEED
    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48
    GOTO MAIN

    RETURN


    '*************************************************************
    '                    K E Y  시 작  1차 수 정 2017.08.10
    '                                 2차 수 정 2017.08.13
    '*************************************************************

    '*************************************************************
    '                    공 통 사 용  K E Y  시 작 ! ! !
    '*************************************************************

KEY1:
    GOSUB SET_SERVO_SPEED
    GOSUB 모터값조절
    ETX  9600, 0
    GOTO MAIN

KEY2:
    GOSUB SET_SERVO_SPEED
    GOSUB 모터값조절_대기
    ETX  9600, 0
    GOTO MAIN

KEY3:
    GOSUB 속도조절
    ETX  9600, 0
    GOTO MAIN

KEY4:
    GOSUB SET_SERVO_SPEED
    GOSUB 모터값얻기
    GOTO MAIN

KEY5:
    GOSUB SET_SERVO_SPEED
    GOSUB 팔머리토크해제
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    자 세   K E Y  시 작 ! ! !
    '*************************************************************

KEY6:
    GOSUB SET_SERVO_SPEED
    GOSUB 기본자세
    ETX  9600, 0
    GOTO MAIN

KEY7:
    GOSUB SET_SERVO_SPEED
    GOSUB 보드연결자세
    ETX  9600, 0
    GOTO MAIN

KEY8:
    GOSUB SET_SERVO_SPEED
    GOSUB 검은선확인자세
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    보 행   K E Y  시 작 ! ! !
    '*************************************************************

KEY9:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 전진보행
    ETX  9600, 0
    GOTO MAIN

KEY10:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 빠른전진보행
    ETX  9600, 0
    GOTO MAIN

KEY11:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 짧은전진보행1
    ETX  9600, 0
    GOTO MAIN

KEY12:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 짧은전진보행2
    ETX  9600, 0
    GOTO MAIN

KEY13:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 짧은전진보행3
    ETX  9600, 0
    GOTO MAIN

KEY14:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 후진보행
    ETX  9600, 0
    GOTO MAIN

KEY15:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 낮은전진종종걸음
    ETX  9600, 0
    GOTO MAIN

KEY16:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 전진종종걸음_안정화3
    ETX  9600, 0
    GOTO MAIN

KEY17:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 전진종종걸음_계단부딪히기
    ETX  9600, 0
    GOTO MAIN

KEY18:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 후진종종걸음
    ETX  9600, 0
    GOTO MAIN

KEY19:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 기어가기
    ETX  9600, 0
    GOTO MAIN

KEY20:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 달리기_32
    ETX  9600, 0
    GOTO MAIN

KEY21:
    ETX  9600, 255
    GOSUB RECEIVE_DATA
    횟수 = RECEIVED_DATA

    GOSUB 달리기_3
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                  기 본 동 작   K E Y  시 작 ! ! !
    '*************************************************************

KEY22:
    '    GOSUB 왼쪽옆으로_약
    GOSUB 왼쪽옆으로_약2
    ETX  9600, 0
    GOTO MAIN

KEY23:
    GOSUB 왼쪽옆으로_중
    ETX  9600, 0
    GOTO MAIN

KEY24:
    '    GOSUB 왼쪽옆으로_강
    ETX  9600, 0
    GOTO MAIN

KEY25:
    '    GOSUB 오른쪽옆으로_약
    GOSUB 오른쪽옆으로_약2
    ETX  9600, 0
    GOTO MAIN

KEY26:
    GOSUB 오른쪽옆으로_중
    ETX  9600, 0
    GOTO MAIN

KEY27:
    '    GOSUB 오른쪽옆으로_강
    ETX  9600, 0
    GOTO MAIN

KEY28:
    GOSUB 왼쪽회전_4
    ETX  9600, 0
    GOTO MAIN

KEY29:
    GOSUB 왼쪽회전_6
    ETX  9600, 0
    GOTO MAIN

KEY30:
    GOSUB 왼쪽회전_27
    ETX  9600, 0
    GOTO MAIN

KEY31:
    GOSUB 왼쪽회전_30
    ETX  9600, 0
    GOTO MAIN

KEY32:
    GOSUB 오른쪽회전_4
    ETX  9600, 0
    GOTO MAIN

KEY33:
    GOSUB 오른쪽회전_6
    ETX  9600, 0
    GOTO MAIN

KEY34:
    GOSUB 오른쪽회전_27
    ETX  9600, 0
    GOTO MAIN

KEY35:
    GOSUB 오른쪽회전_30
    ETX  9600, 0
    GOTO MAIN


    '*************************************************************
    '                    장 애 물   K E Y  시 작 ! ! !
    '*************************************************************

KEY36:
    GOSUB 빨간계단_구르기
    ETX 9600, 0
    GOTO MAIN

KEY37:
    GOSUB 빨간계단_내리기
    ETX 9600, 0
    GOTO MAIN

KEY38:
    GOSUB 지뢰보행
    ETX 9600, 0
    GOTO MAIN

KEY39:
    GOSUB 허들
    ETX 9600, 0
    GOTO MAIN

KEY40:
    GOSUB 계단오르기2
    ETX 9600, 0
    GOTO MAIN

KEY41:
    'GOSUB 초록다리
    ETX 9600, 0
    GOTO MAIN

KEY42:
    GOSUB 계단내리기2
    ETX 9600, 0
    GOTO MAIN

KEY43:
    'GOSUB 골프공1
    ETX 9600, 0
    GOTO MAIN

KEY44:
    GOSUB 골프공_차기
    ETX 9600, 0
    GOTO MAIN

KEY45:
    'GOSUB 골프공마지막
    ETX 9600, 0
    GOTO MAIN

KEY46:
    GOSUB 계단오르기2
    ETX 9600, 0
    GOTO MAIN

KEY47:
    GOSUB 함정
    ETX 9600, 0
    GOTO MAIN

KEY48:
    'GOSUB 수평바리케이트
    ETX 9600, 0
    GOTO MAIN

