## [ Develop Environment ]

- Language : Swift 5.7
- iOS Deployment Target : 15.0
- Xcode : 14.0

# 아우토크립트  

### 1. 제공된 API를 사용하여 JSON 데이터를 요청 후 리스트 형식으로 출력  

![스크린샷 2022-10-22 오후 2 45 47](https://user-images.githubusercontent.com/50910456/197322608-215f9281-a44b-475b-88c3-3ffc50b3ab85.png)  

예방접종센터 위치 정보 API를 Alamofire을 사용하여 get으로 요청합니다. 그 값은 Observable로 return이 되며 성공이면 onNext로 보내고 실패면 onError를 보냅니다.

![스크린샷 2022-10-22 오후 3 58 52](https://user-images.githubusercontent.com/50910456/197325328-50dbcb0a-b79c-4ce7-bdb6-6cd67f40a8da.png)  


viewModel에서 API를 통해 받은 위치 정보를 subscribe 해줍니다. 

![스크린샷 2022-10-22 오후 2 56 16](https://user-images.githubusercontent.com/50910456/197323102-05c2092e-c6c7-4de5-9bc8-229074981faf.png)  

view에서 viewModel에 위치 정보를 가져오는 부분을 bind 처리를 해주면 정상적으로 view가 업데이트되면서 리스트가 출력이 됩니다.  

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 15 10 29](https://user-images.githubusercontent.com/50910456/197323436-cb79cc65-78d2-4142-b163-3506f06e8f5c.gif)  

---

### 2. 하단으로 스크롤시 자동으로 다음페이지 요청 (페이지당 10개씩)  

![스크린샷 2022-10-22 오후 3 19 00](https://user-images.githubusercontent.com/50910456/197323691-0cd37a13-59ab-4200-a001-e256c74dd3d9.png)  

현재 사용자가 스크롤 한 후에 그 지점이 (스크롤 뷰의 컨텐츠 사이즈(컨텐츠 전체 크기) - tableView의 높이(사용자가 보고 있는 뷰의 높이)) 보다 크다면 하단에 도달했다고 판단하고 다음 페이지를 요청합니다. 추가로 -20을 해주어서 하단에 닿기 전, 어느 정도 하단에 도달하게 되면 다음 페이지를 요청하게 했습니다.

![스크린샷 2022-10-22 오후 3 57 50](https://user-images.githubusercontent.com/50910456/197325288-37d684b3-7f1c-405a-8517-f64f8ab262ab.png)


다음 페이지를 요청받게 되면 pageCount를 +1 해주어서 API를 요청하게 됩니다. 이미 View에서는 binding 처리가 돼 있기 때문에 자동으로 리스트가 업데이트됩니다. 

![스크린샷 2022-10-22 오후 3 33 01](https://user-images.githubusercontent.com/50910456/197324198-7378192c-e609-45b5-a0cf-0ba66b715499.png)  

데이터를 10개씩 요청했는데 만약 받은 데이터 카운터가 10개보다 작다면 그다음으로 불러올 데이터가 없다는 뜻이므로 이다음부터는 요청하지 못하게 합니다.  

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 16 01 30](https://user-images.githubusercontent.com/50910456/197325523-5e9d1ed9-5164-4163-9346-574a40fc9381.gif)


---  

### 3. "updateAt"을 기준으로 내림차순 리스트 정렬  

![스크린샷 2022-10-22 오후 3 36 02](https://user-images.githubusercontent.com/50910456/197324347-bee6ad9b-351e-4ebc-ada6-228ed17c7baf.png)  

API를 통해 받은 데이터를 map으로 내림차순 정렬시킨 후에 return 시킵니다.  

![스크린샷 2022-10-22 오후 3 56 44](https://user-images.githubusercontent.com/50910456/197325222-27fba330-4a86-4f7d-9d86-78ac5b0c31b1.png)

하단으로 스크롤 해서 데이터가 10개 추가가 되면 기존에 있던 데이터와 새로 받은 데이터들을 합쳐서 sort 합니다.  

---  

### 4. 생성된 리스트에서 하나의 아이템을 선택하면 디테일 화면으로 이동  
### 5. 디테일 화면에서는 선택한 아이템의 정보를 출력  

![스크린샷 2022-10-22 오후 4 03 14](https://user-images.githubusercontent.com/50910456/197325597-4d3e87db-d391-44cb-8da9-84043c5525f6.png)  

cell을 클릭하면 그 cell이 가지고 있는 center 데이터를 가지고 디테일 화면으로 이동합니다. 디테일 뷰에서는 받아온 center 데이터를 가지고 center의 정보를 보여줍니다.

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 16 04 16](https://user-images.githubusercontent.com/50910456/197325646-f2c8e42e-ce52-4778-949f-d334e04a2808.gif)  

---  

### 6. 지도에서는 현재 위치 오버레이와 접종센터 마커를 노출  

![스크린샷 2022-10-22 오후 4 08 55](https://user-images.githubusercontent.com/50910456/197325845-9beba716-3bd1-4848-816b-90d44125dabe.png)

현재 위치정보를 가져오려면 위치 권한이 필요합니다. 처음에 지도에 접근하게 되면 위치 권한을 물어봅니다.

![스크린샷 2022-10-22 오후 4 10 57](https://user-images.githubusercontent.com/50910456/197325893-936e6154-5a8e-4c32-98d4-1de6ff857ea7.png)  


![스크린샷 2022-10-22 오후 4 14 13](https://user-images.githubusercontent.com/50910456/197326010-8c5a7ae7-e8f7-4e6a-9a7e-96311a79d055.png)  

접종센터로 버튼 클릭 시 center 데이터 안에 있는 lat, lng 좌표를 가지고 Map을 이동시킵니다.  

현재위치로 버튼 클릭 시 만약 위치 권한이 거절인 상태라면 위치서비스를 켤 수 있도록 설정 창으로 이동, 위치 권한이 설정된 상태라면 현재 사용자 위치의 좌표를 받아서 Map을 이동시킵니다.  

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 16 18 10](https://user-images.githubusercontent.com/50910456/197326137-af35836f-6fb1-4d4e-96c6-ef26dcc14d18.gif)

---  

### scroll To Top  

![스크린샷 2022-10-22 오후 5 50 27](https://user-images.githubusercontent.com/50910456/197330416-9d97e2a1-dc68-434f-92f1-e868fe9a66bb.png)  

indexPath 0, 테이블 뷰 제일 위로 이동시킵니다.

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 17 49 08](https://user-images.githubusercontent.com/50910456/197330407-ee90d6a8-a8fc-488a-9cec-e1cb285f5d69.gif)  

### tableView refresh  

![스크린샷 2022-10-22 오후 5 56 57](https://user-images.githubusercontent.com/50910456/197330710-3cf1592f-bce9-4fc4-b118-7a7b2e0a27f9.png)  

tableView에 UIRefreshControl()를 추가시키고 상단으로 끌어당겼을 때 refreshData을 호출합니다.

![스크린샷 2022-10-22 오후 5 55 11](https://user-images.githubusercontent.com/50910456/197330619-047dbaed-2a0d-427e-91b5-0358b349bca8.png)  

refreshCheck가 true이기 때문에 불러온 데이터만 새로 추가시킵니다.

![Simulator Screen Recording - iPhone 11 - 2022-10-22 at 17 58 05](https://user-images.githubusercontent.com/50910456/197330771-1f217d6a-e7dd-411a-894c-f0be805cb8e5.gif)



