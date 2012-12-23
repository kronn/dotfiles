import Control.OldException(catchDyn,try)
import Control.Concurrent
import DBus
import DBus.Connection
import DBus.Message
import System.Cmd
import System.Exit
import XMonad
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Config.Gnome
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ServerMode
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Replace
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowBringer
import XMonad.Actions.Commands
import XMonad.Actions.GridSelect
import XMonad.Actions.FloatKeys
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.Maximize
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.SimplestFloat
import XMonad.Layout.CenteredMaster
import XMonad.Layout.MagicFocus

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = withConnection Session $ \ dbus -> do
  getWellKnownName dbus
  replace
  xmonad $ withUrgencyHook NoUrgencyHook
         $ gnomeConfig {
           normalBorderColor  = "#000000",
           -- focusedBorderColor = "#ffffff",
           focusedBorderColor = "#8BAFDB",
           modMask            = mod4Mask,
           terminal           = "gnome-terminal --profile=XMonad",
           borderWidth        = 1,
           focusFollowsMouse  = False,
           keys               = myKeys,
           mouseBindings      = myMouseBindings,
           manageHook         = manageHook gnomeConfig <+> composeAll managementHooks <+> manageDocks,
           logHook            = updatePointer (Relative 0 0) >> dynamicLogWithPP (myPrettyPrinter dbus),
           startupHook        = startupHook gnomeConfig >> setWMName "LG3D",
           layoutHook         = myLayout,
           handleEventHook    = serverModeEventHook
           }

-- -----------------------------------------------------------------------------

myLayout =  avoidStruts $ smartBorders $ layoutHintsWithPlacement (0.5, 0.5) 
            $ maximize ( simplestFloat ||| TwoPane (3/100) (1/2) ||| tiled ||| Mirror tiled ||| Grid ||| Full )
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

myPrettyPrinter :: Connection -> PP
myPrettyPrinter dbus = defaultPP {
    ppOutput  = outputThroughDBus dbus
  , ppUrgent  = pangoColor "#ff0000" . wrap "" "!" . pangoSanitize
  , ppTitle   = pangoColor "#003366" . shorten 50 . pangoSanitize
  , ppCurrent = pangoColor "#006666" . wrap "[" "]" . pangoSanitize
  , ppVisible = pangoColor "#663366" . wrap "(" ")" . pangoSanitize
  , ppSep     = " | "
  , ppWsSep   = ""
  , ppHidden  = wrap " " " "
  , ppLayout  = pangoColor "black" .
                (\x -> case x of
                    "Hinted Maximize SimplestFloat"   -> "Float"
                    "Hinted Maximize TwoPane"         -> "TwoPane"
                    "Hinted Maximize Tall"            -> "Tall"
                    "Hinted Maximize Mirror Tall"     -> "Wide"
                    "Hinted Maximize Full"            -> "Full"
                    "Hinted Maximize Grid"            -> "Grid"
                    _                                 -> x
                )
  }

managementHooks :: [ManageHook]
managementHooks = [
    resource        =? "Do"                          --> doIgnore
    , resource      =? "desktop_window"              --> doIgnore
    , resource      =? "kdesktop"                    --> doIgnore
    , className     =? "MPlayer"                     --> doFloat
    , className     =? "Gimp"                        --> doFloat
    , className     =? "VirtualBox"                  --> doFloat
    , className     =? "Xmessage"                    --> doCenterFloat      
    , className     =? "term-htop"                   --> doCenterFloat
    , isFullscreen                                   --> doFullFloat
  ]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    --, ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((mod1Mask,           xK_F2    ), spawn "custom-run")

    -- launch gmrun
    --, ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
    -- close focused window
    , ((mod1Mask,           xK_F4    ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((mod1Mask .|. shiftMask, xK_Tab     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm,                xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm,                xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    --, ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm .|. shiftMask, xK_j     ), sendMessage Shrink)

    -- Expand the master area
    --, ((modm,               xK_l     ), sendMessage Expand)
    , ((modm .|. shiftMask, xK_k     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_q     ), spawn "gnome-session-save --logout")
 
    -- Restart xmonad
    , ((modm              , xK_BackSpace     ), spawn "xmonad --recompile; xmonad --restart")
      
    -- Extra WM actions          
    , ((mod1Mask,           xK_Escape  ), withFocused (sendMessage . maximizeRestore))
    -- , ((modm,               xK_Left    ), prevWS)
    -- , ((modm,               xK_Right   ), nextWS)
    , ((modm,               xK_Left    ), withFocused (keysMoveWindow (-10, 0)))
    , ((modm,               xK_Right   ), withFocused (keysMoveWindow (10, 0)))
    , ((modm,               xK_Up      ), withFocused (keysMoveWindow (0, -10)))
    , ((modm,               xK_Down    ), withFocused (keysMoveWindow (0, 10)))
    , ((modm .|. shiftMask, xK_Left    ), shiftToPrev)
    , ((modm .|. shiftMask, xK_Right   ), shiftToNext)
    , ((modm,               xK_Tab     ), toggleWS)
    , ((modm,               xK_w       ), gotoMenu)
    , ((modm,               xK_e       ), goToSelected defaultGSConfig)
      
    -- Launching applications
    , ((modm,                 xK_r     ), spawn "bashwall -sr")
    , ((modm,                 xK_f     ), spawn "gnome-open ~/")
    , ((modm,                 xK_s     ), spawn "toggle-htop")
    , ((modm,                 xK_m     ), spawnSelected defaultGSConfig ["mpd-Play-Pause", "mpd-Stop", "mpd-Next", "mpd-Prev"])
    , ((modm .|. shiftMask,   xK_e     ), spawn "emacsclient -c")
    , ((modm .|. shiftMask,   xK_w     ), spawn "gnome-appearance-properties -p background")
    , ((modm .|. shiftMask,   xK_F4    ), spawn "xkill")
    , ((modm .|. controlMask, xK_F4    ), spawn "xkill")
    --, ((mod1Mask,             xK_F1    ), spawn "gnome-panel-control --main-menu")
    , ((0,                    xK_Print ), spawn "custom-screenshot")

    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_F1, xK_F2, xK_F3] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 

------------------------------------------------------------------------
-- My Functions

-- gridSelectMusic = do 
--   selected <- gridselect defaultGSConfig [("Play/Pause", "a"), ("Next", "a"), ("Previous", "a"), ("Stop", "a") ]
--   case selected of
--     "Play/Pause"  -> spawn "mpc toggle"
--     "Next"        -> spawn "mpc next"
--     "Previous"    -> spawn "mpc prev"
--     "Stop"        -> spawn "mpc stop"
--     _             -> putStrLn "Uknown action - gridSelectMusic"

------------------------------------------------------------------------
-- Boring DBus stuff

-- This retry is really awkward, but sometimes DBus won't let us get our
-- name unless we retry a couple times.
getWellKnownName :: Connection -> IO ()
getWellKnownName dbus = tryGetName `catchDyn` (\ (DBus.Error _ _) ->
                                                getWellKnownName dbus)
 where
  tryGetName = do
    namereq <- newMethodCall serviceDBus pathDBus interfaceDBus "RequestName"
    addArgs namereq [String "org.xmonad.Log", Word32 5]
    sendWithReplyAndBlock dbus namereq 0
    return ()

outputThroughDBus :: Connection -> String -> IO ()
outputThroughDBus dbus str = do
  let str' = "<span font=\"Terminus 9 Bold\">" ++ str ++ "</span>"
  msg <- newSignal "/org/xmonad/Log" "org.xmonad.Log" "Update"
  addArgs msg [String str']
  send dbus msg 0 `catchDyn` (\ (DBus.Error _ _ ) -> return 0)
  return ()

pangoColor :: String -> String -> String
pangoColor fg = wrap left right
 where
  left  = "<span foreground=\"" ++ fg ++ "\">"
  right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
 where
  sanitize '>'  acc = "&gt;" ++ acc
  sanitize '<'  acc = "&lt;" ++ acc
  sanitize '\"' acc = "&quot;" ++ acc
  sanitize '&'  acc = "&amp;" ++ acc
  sanitize x    acc = x:acc

try_ :: MonadIO m => IO a -> m ()
try_ action = liftIO $ try action >> return ()
