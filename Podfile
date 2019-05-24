# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
    # Pods for Rover
    pod 'PinLayout', :inhibit_warnings => true
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxOptional'
    pod 'IQKeyboardManagerSwift'
    pod 'CoreStore'
    pod 'MaterialComponents/Cards'
    pod 'MaterialComponents/TextFields'
end

target 'Rover' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods

  target 'RoverTests' do
    inherit! :search_paths
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxBlocking'
  end

end
