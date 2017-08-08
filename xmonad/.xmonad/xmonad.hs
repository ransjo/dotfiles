--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog

import XMonad.Layout.Maximize
import XMonad.Layout.NoBorders
import XMonad.Layout.HintedGrid
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.Util.NamedScratchpad
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowBringer


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
-- sTerminal = "st"
-- myTerminal      = sTerminal ++ " -e tmux"
sTerminal = "urxvtc"
myTerminal = sTerminal
scratchTerminal = "urxvtc"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"


scratchConsole name l t w h = NS name (spawnConsole name) (findConsole name) (manageConsole l t w h)
  where spawnConsole name = scratchTerminal ++ " -name " ++ name
        findConsole name = resource =? name
        manageConsole l t w h = customFloating $ W.RationalRect l t w h

myScratchpads = [ scratchConsole "bottom-console" ((1 - w) / 2) (1 - h) w h
                , scratchConsole "top-console" ((1 - w) / 2) 0 w h ]
  where w = 0.5
        h = 0.3

dmenu = "dmwrapper"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask, xK_Return), spawn $ XMonad.terminal conf)

      -- launch scratch console
    , ((modMask,               xK_o), namedScratchpadAction myScratchpads "bottom-console")
    , ((modMask,               xK_i), namedScratchpadAction myScratchpads "top-console")

    , ((modMask .|. controlMask, xK_Return), spawn $ sTerminal)
      -- Window Bringer
    , ((modMask,               xK_y), gotoMenuArgs' dmenu ["-p", "Goto", "-l", "10"])
    , ((modMask .|. shiftMask, xK_y), bringMenuArgs' dmenu ["-p", "Bring", "-l", "10"])

      -- launch emacs
    , ((modMask,               xK_e     ), spawn "~/bin/edit")
    , ((modMask,               xK_f     ), spawn "~/bin/edir")
    , ((modMask .|. shiftMask, xK_f     ), spawn "~/bin/eterm")

    -- launch dmenu
    , ((modMask, xK_d ), spawn "dmenu_recent")
    , ((modMask,               xK_t     ), spawn "~/bin/dmenu_tmux")
    , ((modMask,               xK_r     ), spawn "~/bin/dmenu_recentf")

    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "xfce4-appfinder")

    -- close focused window
    , ((modMask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask .|. shiftMask, xK_m     ), windows W.focusMaster  )

    -- Maximize the focused window temporarily
    , ((modMask,               xK_m     ), withFocused $ sendMessage . maximizeRestore)

    -- Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask .|. shiftMask, xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask              , xK_b     ),

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    --, ((modMask .|. shiftMask, xK_q     ), spawn "xfce4-session-logout")

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True)

    -- to hide/unhide the panel
    , ((modMask              , xK_b), sendMessage ToggleStruts)

    -- switch keyboard layouts
    , ((modMask , xK_F10), spawn "~/keyboard/se.sh")
    , ((modMask , xK_F11), spawn "~/keyboard/us.sh")
    , ((modMask , xK_F12), spawn "~/keyboard/gr.sh")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++
    [((modMask, xK_w), swapNextScreen),
     ((modMask .|. shiftMask, xK_w), shiftNextScreen)
    ]
--   ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 1), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

funLayout = spacing 15 $ ThreeColMid 1 (3/100) (1/2)

myLayout =  maximize (tiled) ||| Full ||| funLayout
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "mpv"            --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Xfce4-appfinder"  --> doFloat
    , className =? "Xfrun4"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
    <+> namedScratchpadManageHook myScratchpads

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
myLogHook = ewmhDesktopsLogHookCustom namedScratchpadFilterOutWorkspace
--myLogHook = dynamicLogWithPP dzenPP

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = ewmhDesktopsStartup >> setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad $ docks defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = avoidStruts $ smartBorders $ myLayout,
        manageHook         = manageDocks <+> myManageHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook,
        handleEventHook = ewmhDesktopsEventHook
    }
