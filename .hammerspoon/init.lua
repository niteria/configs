local hotkey = require "hs.hotkey"
local modal_hotkey = hotkey.modal
local hyper = {"cmd", "alt", "ctrl", "shift"}

hs.hints.hintChars = {"Q","W","E","R","A","S","D","F","Z","X","C","V","1","2","3","4"}
hs.hints.showTitleThresh = 0

hs.hotkey.bind(hyper, "F", function()
  hs.hints.windowHints(nil, function() 
  end)
end)

-----------------------------
-- Grids
--

hs.grid.setGrid('2x2')
hs.grid.setGrid('3x2', '2560x1600')
hs.grid.setMargins('0x0')

-- disable animation
hs.window.animationDuration = 0

hs.hotkey.bind(hyper, ';', function() 
  hs.grid.snap(hs.window.focusedWindow()) 
end)

-----------------------------
-- Window movement and resizing
--
-- Numbers the grid "quadrants" like this:
-- 
--   1 | 2
--   -----
--   3 | 4
--
-- When you press Hyper-M, it expects a grid quadrant followed
-- by resizing directives: `d` for down, `r` for right.
-- It then expects `enter`.
-- `escape` can be used to cancel.
--
-- When resize is out of bounds of the grid it just applies the command.
--
-- For example Hyper-m 1d enter will take the window, move it to first quadrant
-- and resize it one grid position `d`own.
-- 1dd would do the same for 2x2 grid.

hs.hotkey.bind(hyper, 'M', function()
  processMove()
end)

function processMove() 
  k = modal_hotkey.new(nil, nil)
  k:bind({}, 'escape', function() 
    k:exit() 
  end)
  local w,h = hs.grid.getGrid(hs.window.focusedWindow():screen())
  local id = 1
  for i = 0,h-1,1 do
    for j = 0,w-1,1 do
      k:bind({}, "" .. id, function() 
        processResize(k, j, i, 1, 1)
      end)
      id = id + 1
    end
  end
  k:enter()
end

function processResize(k, x, y, w, h) 
  k:exit() 
  local gw,gh = hs.grid.getGrid()
  -- allow out of bounds for early exit
  if w > gw or h > gh then
    hs.grid.set(hs.window.focusedWindow(), { x = x, y = y, w = w, h = h })
    return
  end
  k = modal_hotkey.new(nil, nil)
  k:bind({}, 'escape', function() 
    k:exit() 
  end)
  k:bind({}, 'd', function() 
    processResize(k, x, y, w, h + 1)
  end)
  k:bind({}, 'r', function() 
    processResize(k, x, y, w + 1, h)
  end)
  k:bind({}, 'return', function() 
    hs.grid.set(hs.window.focusedWindow(), { x = x, y = y, w = w, h = h })
    k:exit() 
  end)
  k:enter()
end

-----------------------------
-- Focusing near windows
--

hs.hotkey.bind(hyper, 'right', function() 
  hs.window.focusedWindow():focusWindowEast(nil, true)
end)

hs.hotkey.bind(hyper, 'left', function() 
  hs.window.focusedWindow():focusWindowWest(nil, true)
end)

hs.hotkey.bind(hyper, 'up', function() 
  hs.window.focusedWindow():focusWindowNorth(nil, true)
end)

hs.hotkey.bind(hyper, 'down', function() 
  hs.window.focusedWindow():focusWindowSouth(nil, true)
end)


-----------------------------
-- Reloading
--

hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-----------------------------
-- Useless crap
--

-- local mouseCircle = nil
-- local mouseCircleTimer = nil

-- function mouseHighlight()
--     -- Delete an existing highlight if it exists
--     if mouseCircle then
--         mouseCircle:delete()
--         if mouseCircleTimer then
--             mouseCircleTimer:stop()
--         end
--     end
--     -- Get the current co-ordinates of the mouse pointer
--     mousepoint = hs.mouse.get()
--     -- Prepare a big red circle around the mouse pointer
--     mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
--     mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
--     mouseCircle:setFill(false)
--     mouseCircle:setStrokeWidth(5)
--     mouseCircle:show()

--     -- Set a timer to delete the circle after 3 seconds
--     mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
-- end
-- hs.hotkey.bind(hyper, "D", mouseHighlight)

-- hs.hotkey.bind(hyper, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send():release()
-- end)

