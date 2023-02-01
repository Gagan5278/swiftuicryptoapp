# swiftuicryptoapp
### An app written in 100% SwiftUI, displyaing live Crypto currencies data from CoinGeko (https://www.coingecko.com/) api. App uses core data for data persistence. 

### Screenshots

#### 1. Animated splash screen

![animated_splash_screen] <img src="https://user-images.githubusercontent.com/2304583/216149514-7dacaecf-88c9-45fa-abb6-aac045031bd4.png" width=25% height=25%> 
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
![main_landing_screen](https://user-images.githubusercontent.com/2304583/216150299-ec78ee44-59cb-43ce-ac18-504ea59321b5.png)

#### 3. Add Portfolio screen
![adding_portfolio_screen](https://user-images.githubusercontent.com/2304583/216150276-f9cc35be-e2b3-4da8-b677-be2172e64170.png)

#### 4. Coin detail screen
![coin_detail_screen_positive](https://user-images.githubusercontent.com/2304583/216150280-761296ab-c7d2-4c9f-a59e-b6be56cbddc3.png)

#### 3. Empty Portfolio screen
![empty_add_portfolio_Screen](https://user-images.githubusercontent.com/2304583/216150289-e3ff533d-7c4a-4ecb-ada4-d94d5d74506e.png)

#### 4. Non-Empty Portfolio screen
![non_empty_portfolio_screen](https://user-images.githubusercontent.com/2304583/216150304-88e533b6-a108-4d10-b316-9921a054ca76.png)

#### 5. Search coin screen
![search_coin_portfolio](https://user-images.githubusercontent.com/2304583/216150305-9303dec4-bed4-44d9-9071-7e1046f7e582.png)

#### 5. Settings screen
![setting_screen](https://user-images.githubusercontent.com/2304583/216150306-53e5941a-48f9-47c3-9102-a92c62c813df.png)
