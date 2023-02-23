# 🎁 OpenMarket 

#### Coordinator 적용한 이유
- 이전 프로젝트 에서 각각 다른 View 에서 동일한 View로 화면전환시 중복코드가 생겨나고, 각 다른 View에서 동일한 Class 인스턴스 를 주입받아야 하는 상황이 발생해 이를 해결하고자 Coordinator 패턴에 대해 공부하고 적용했습니다.
- Coordinator 패턴을 적용해 화면 전환 로직을 ViewController 에서 분리 하였고, ViewController 간의 의존성을 제거 하였습니다.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### 적용한 이유
- 기존 MVVM의 경우 MVC보다는 계층이 분리되고, 객체들의 관심사가 분리되지만 그럼에도 ViewModel의 역할이 커지는 문제가 발생했습니다.
- CleanArchitecture를 통해 Layer를 한층 더 나누어 주면서 계층별로 관심사가 나누어지게 되고, 자연스럽게 각각의 객체들의 역할이 나누어 지도록 하였습니다.
- 이로 인해 객체들의 결합도가 낮아지고, 응집도는 높아지면서 문제가 발생했을 때 쉽게 찾을 수 있고 해당 부분만 수정이 가능해지면서 유지보수적인 측면에서 상당한 이점을 갖을 수 있게 되었습니다.
