# Together (with Firebase) - 프로젝트 협업 앱 
> 사용자들이 프로젝트를 생성하고 가입하여 일정, 파일들을 공유하는 서비스를 제공합니다.
> Flutter + Firebase를 사용한 앱입니다.


<br><br>

## 주요 기능
 - 로그인, 회원가입 
    - Firebase Authentication의 이메일/비밀번호을 통한 로그인, 회원가입
- 일정
    - Firebase Database를 이용해 일정 데이터 생성, 조회, 삭제 기능 구현
    - 캘린더 화면에서 날짜를 클릭하면 해당 날짜의 일정을 리스트 형태로 확인할 수 있음
- 파일
    - Firebase Storage를 통해 업로드, 다운로드, 삭제 기능 구현


<br><br>


## 화면
![Screenshot_1713891773](https://github.com/bymine/together_flutter/assets/71866185/de621aa6-46d7-4ce6-9ba8-71df8504c014) |![file](https://github.com/bymine/together_flutter/assets/71866185/f235596e-1a4e-49e8-aa78-31d6e7647200) |![file2](https://github.com/bymine/together_flutter/assets/71866185/4a42abfb-6731-4418-8966-011e8c6a133d) |![schedule](https://github.com/bymine/together_flutter/assets/71866185/fd1b1296-c9f1-44fb-939b-ce931b6a7f23)
--- | --- | --- | --- | 

<br><br>

## 기술적 구현 사항

### GetX를 사용하여 MVC(Model-View-Controller) 아키텍처를 구현

- Model 폴더: 각각의 데이터 모델을 정의
- Controller 폴더: 비즈니스 로직을 처리하고 화면의 상태를 관리
- View(Page) 폴더: 사용자에게 보여지는 화면을 정의
- Bindings 폴더: 각 화면에 필요한 의존성을 주입하고 초기화하는데 사용
