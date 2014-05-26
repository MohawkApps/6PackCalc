class AppDelegate < ProMotion::Delegate
  tint_color "#B37E07".to_color

  def on_load(app, options)
    setup
    appearance

    open UINavigationController.alloc.initWithRootViewController(CalculatorScreen.new)
  end

  def setup
    BW.debug = true unless App.info_plist['AppStoreRelease'] == true
    BW.use_weak_callbacks = true

    # 3rd Party integrations
    # Only do this on the device
    if !Device.simulator?
      app_id = App.info_plist['APP_STORE_ID']

      # Flurry
      NSSetUncaughtExceptionHandler("uncaughtExceptionHandler")
      Flurry.startSession("3V3948P3TTBP2HGPRLCU")

      # Appirater
      Appirater.setAppId app_id
      Appirater.appLaunched true

      # Harpy
      Harpy.sharedInstance.setAppID app_id
      Harpy.sharedInstance.checkVersion
    end
  end

  def appearance
    nav_bar = UINavigationBar.appearance
    nav_bar.setBarStyle UIBarStyleBlack
    nav_bar.setBarTintColor "#B37E07".to_color
    nav_bar.setTintColor UIColor.whiteColor
    nav_bar.setTitleTextAttributes({
      UITextAttributeTextColor => UIColor.whiteColor
    })

    UIBarButtonItem.appearance.setTintColor "#B37E07".to_color
  end

  #Flurry exception handler
  def uncaughtExceptionHandler(exception)
    Flurry.logError("Uncaught", message:"Crash!", exception:exception)
  end

  def will_enter_foreground
    Appirater.appEnteredForeground true unless Device.simulator?
  end
end
