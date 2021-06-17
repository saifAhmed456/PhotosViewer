**Description :**
# PhotosViewer
Shows a list of albums initially.
Selcting any album will lead to a photos list screen
Tapping on any photo will display a photo detail screen

Language Used : Swift

Frameworks :
1.RxSwift
2.Moya

Architecture Pattern : MVVM

MVVM pattern has been strictly followed through out the applicaion. 
Protocols also have been used as a layer of abstraction.
RxSwift has been used for bindings betwween view and view models.
Moya has been used to make network calls.
The api calls are cached in order to reduce network data consumption.
