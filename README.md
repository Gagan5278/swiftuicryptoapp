# swiftuicryptoapp
### An app written in 100% SwiftUI, displyaing live Crypto currencies data from CoinGeko (https://www.coingecko.com/) api. App uses core data for data persistence. 

### Screenshots

#### 1. Animated splash screen

 <img src="https://user-images.githubusercontent.com/2304583/216149514-7dacaecf-88c9-45fa-abb6-aac045031bd4.png" width=25% height=25%> 
 ##### There is another animated splash screen with Image animation. Open CrytoCurrencyApp.swift and uncomment second part for app launch
 ```
              // Launch animation with image
            /*
             ZStack {
             NavigationView {
             HomeView()
             .navigationBarHidden(true)
             }
             if launchScreenState.state != .finished {
             LaunchScreenViewWithImage()
             }
             }
             .environmentObject(homeViewModel)
             .environmentObject(launchScreenState)
             */
 ```
 
 Also, in file HomeView.swift, also uncomment 
 ```
         .onAppear {
            // MARK: - code for Launch animation with image
            // handleLaunchScreenAnimation()
        }
 ```

#### 2. Main Home screen

 <img src="https://user-images.githubusercontent.com/2304583/216150299-ec78ee44-59cb-43ce-ac18-504ea59321b5.png" width=25% height=25%> 

#### 3. Add Portfolio screen
 <img src="https://user-images.githubusercontent.com/2304583/216150276-f9cc35be-e2b3-4da8-b677-be2172e64170.png" width=25% height=25%> 

#### 4. Coin detail screen
 <img src="https://user-images.githubusercontent.com/2304583/216150280-761296ab-c7d2-4c9f-a59e-b6be56cbddc3.png" width=25% height=25%> 

#### 3. Empty Portfolio screen
 <img src="https://user-images.githubusercontent.com/2304583/216150289-e3ff533d-7c4a-4ecb-ada4-d94d5d74506e.png" width=25% height=25%> 

#### 4. Non-Empty Portfolio screen
 <img src="https://user-images.githubusercontent.com/2304583/216150304-88e533b6-a108-4d10-b316-9921a054ca76.png" width=25% height=25%> 

#### 5. Search coin screen
 <img src="https://user-images.githubusercontent.com/2304583/216150305-9303dec4-bed4-44d9-9071-7e1046f7e582.png" width=25% height=25%> 

#### 5. Settings screen
 <img src="https://user-images.githubusercontent.com/2304583/216150306-53e5941a-48f9-47c3-9102-a92c62c813df.png" width=25% height=25%> 

