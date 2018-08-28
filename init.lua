spaces = require("hs._asm.undocumented.spaces")
wf=hs.window.filter
eventtap=hs.eventtap
timer=hs.timer
internal = require('hs._asm.undocumented.spaces.internal')

spaceIds = {}

function setSpaces()
  -- Set spaces
  currentSpace = spaces.activeSpace()
  currentSpaceHotkey = 0

  for i=1,6 do
    eventtap.keyStroke("ctrl", tostring(i))
    while spaces.isAnimating() do
      timer.usleep(5000)
    end
    spaceIds[i] = spaces.activeSpace()
    if (spaces.activeSpace() == currentSpace) then
      currentSpaceHotkey = i
    end
  end

  eventtap.keyStroke("ctrl", tostring(currentSpaceHotkey))
end

function positionApp(appTitle, screen, space)
    for k,v in pairs(hs.application.get(appTitle):allWindows()) do
        if (#internal.windowsOnSpaces(v:id()) <= 1) then
            v:moveToScreen(screen)
            spaces.moveWindowToSpace(v:id(), space)
            v:maximize()
        end
    end
end

function officeStationary()
    -- Window Layout, Office stationary
    setSpaces()

    -- Get screens

    for k,v in pairs(hs.screen.allScreens()) do
        x, y = v:position()

        if x == -2 then
            leftScreen = v
        elseif x == -1 then
            middleScreen = v
        elseif x == 0 then
            rightScreen = v
        end
    end

    positionApp('Google Chrome', rightScreen, spaceIds[1])
    positionApp('Fantastical', middleScreen, spaceIds[1])
    positionApp('Airmail', middleScreen, spaceIds[1])

    positionApp('iTerm2', rightScreen, spaceIds[2])

    positionApp('IntelliJ IDEA', rightScreen, spaceIds[3])

    positionApp('Skype for Business', rightScreen, spaceIds[4])
    positionApp('Microsoft Teams', middleScreen, spaceIds[4])

end

function officeMobile()
    -- Window Layout, Office mobile
    setSpaces()

    -- Get screens

    for k,v in pairs(hs.screen.allScreens()) do
        x, y = v:position()

        screen = v
    end

    positionApp('Google Chrome', screen, spaceIds[1])
    positionApp('Fantastical', screen, spaceIds[1])
    positionApp('Airmail', screen, spaceIds[1])

    positionApp('iTerm2', screen, spaceIds[2])

    positionApp('IntelliJ IDEA', screen, spaceIds[3])

    positionApp('Skype for Business', screen, spaceIds[4])
    positionApp('Microsoft Teams', screen, spaceIds[4])

end

function homeOffice()
    -- Window Layout, Home office

    setSpaces()

    -- Get screens

    for k,v in pairs(hs.screen.allScreens()) do
        x, y = v:position()

        if y == 0 then
            bottomScreen = v
        elseif x == 0 then
            leftScreen = v
        else
            rightScreen = v
        end
    end


    positionApp('Google Chrome', leftScreen, spaceIds[1])
    positionApp('Fantastical', bottomScreen, spaceIds[1])
    positionApp('Airmail', rightScreen, spaceIds[1])

    positionApp('iTerm2', leftScreen, spaceIds[2])

    positionApp('IntelliJ IDEA', leftScreen, spaceIds[3])

    positionApp('Skype for Business', rightScreen, spaceIds[4])
    positionApp('Microsoft Teams', leftScreen, spaceIds[4])

end

hs.urlevent.bind("officeStationary", officeStationary)
hs.urlevent.bind("officeMobile", officeMobile)
hs.urlevent.bind("homeOffice", homeOffice)

menubar = hs.menubar.new()
menubar:setIcon(hs.image.imageFromName("NSHandCursor"))

if menubar then
    menubar:setMenu({
        { title = "Office Stationary", fn = officeStationary },
        { title = "Office Mobile", fn = officeMobile },
        { title = "Homeoffice", fn = homeOffice }
    })
end
