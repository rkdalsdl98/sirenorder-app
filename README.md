<div>
    <h1>SirenOrder-APP</h1>
</div>  

<h2>📚 STACKS</h2>
<div>
  <img src="https://img.shields.io/badge/dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"> <img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
</div>  
<div>  
    <img src="https://img.shields.io/badge/SharedPreferences-41AD48?style=flat-square">
</div>  
<div>  
    <img src="https://img.shields.io/badge/githubactions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white">
</div>   
<div>  
  <img src="https://img.shields.io/badge/Bloc-5387C6?style=flat-square"> <img src="https://img.shields.io/badge/Dio-5C2D91?style=flat-square"> <img src="https://img.shields.io/badge/BlocConcurrency-0056D2?style=flat-square"> <img src="https://img.shields.io/badge/SSEClient-000000?style=flat-square">
</div>  

## App Description  
> 사이렌 오더를 이용하기 위한 전용 어플리케이션 입니다.
앱 스토어에 업로드 하지 않을 것 이며, 데모환경을 구축 준비중입니다.  

## Architecture & State Management  
+ MVVM  
+ Bloc  

## Notification (SSE)  
+ 로그인 시 발급 받은 토큰으로 인증하여 이벤트를 구독하며, 서버에서 보내는 알림을 받아 사용자에게 표시합니다.  
+ 서버와의 상태를 체크하여 연결이 불안정 하거나 이벤트를 받아 올 수 없을 경우 이벤트 구독을 취소하고 사용자에게 표시합니다.  
+ 이를 이용한 백그라운드 알림 메시지를 디바이스 상단에 표기하도록 준비중에 있습니다.  

## Payment (PortOne)  
+ 결제수단은 카카오페이 카드결제로만 가능하며 테스트 환경으로 진행되기 때문에 실 결제와는 다를 수 있습니다.  

## Other Features  
+ 장바구니에 원하는 메뉴를 담고 여러메뉴를 일관주문이 가능합니다.  
(주문 이후에도 장바구니에 메뉴는 삭제하지 않는 이상 사라지지 않습니다.)  
+ 장바구니에 담긴 메뉴의 종류가 주문페이지 하단 장바구니 아이콘에 표기됩니다.
+ 이벤트로 발급, 실물로 지급받은 쿠폰 코드를 등록해 사용 할 수 있습니다.  
+ 쿠폰 회수시 사용자에게 알림이 갑니다.  
(쿠폰함에는 바로 업데이트가 되지 않고 사용시, 재 로그인시에 업데이트 됩니다.)    
+ 내가 선택한 메뉴를 다른 유저에게 선물 할 수 있습니다.  
(쿠폰 형식으로 선물함에 기록되며 선물받은 유저에게 알림이 전달됩니다.)  


## UI   

<div align="center">
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/936e35b0-4626-401f-807a-03edc35f9d90" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/6d8305ac-84cf-4862-b0e7-a6ebf0fdb3bc" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/43476eb8-8ebc-4c20-9ea6-ff2a18ca0031" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/1eeeb71c-00c0-47d7-b958-61fde306d790" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/32227198-dfe2-4a7e-935b-7128d1e26933" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/e246d588-e58a-4b80-8f11-2cf4864f2915" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/5e86d566-4e24-4b3f-b8b0-932a7d7a9aff" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/40a0993a-6b09-4c14-8cd6-21f2dbaefe85" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/e3882fe3-cd5b-4abc-98fc-dd588f766507" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/c51d0e0c-9e39-4ef2-a0ca-eb213f8ab1bf" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/c2ed3f6a-83b8-4b89-b011-02ed5373639e" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/61259b49-b932-43d3-9860-9c41431689e9" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/fc83b917-3212-4f69-a052-7e5c72dad7f2" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/91b7400c-3ad5-473a-bcc7-e19465a760b3" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/91b7400c-3ad5-473a-bcc7-e19465a760b3" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/4de5bce9-065f-4a3d-879c-750df51fc662" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/5efa1ac9-4605-4506-8cd6-e722ac1141dc" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/a96a2281-3bac-494a-9b13-5b58f702e5c9" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/4dddc7bc-29c2-4dff-b2a2-f436b170c12f" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/2f1635b0-c517-4223-96f9-2af92d9839df" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/7f0e12bb-68dc-4957-8e64-7871c95e2e49" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/72423f4f-f929-40e7-9484-848753bd7140" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/c575d3f7-e968-4f6b-9ff6-2e6a4205a9cd" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/ff157073-c966-4780-ad5d-fdceeee4ec1b" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/534aafab-668b-4d02-8280-ec710f43a57b" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/08c19de0-27a7-4928-8e60-74ac67362dd1" width="200" height="355">
</div>  