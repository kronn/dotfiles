import XMonad
-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.ManageDocks
-- import XMonad.Util.Run(spawnPipe)
-- import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    -- xmproc <- spawnPipe "/home/kronn/.cabal/bin/xmobar /home/kronn/.xmobarrc"
    xmonad $ defaultConfig
        {
          -- modMask = mod4Mask,     -- Rebind Mod to the Windows key
          -- terminal = "xterm",
          terminal = "uxterm",
          -- manageHook = manageDocks <+> manageHook defaultConfig,
          -- layoutHook = avoidStruts  $  layoutHook defaultConfig,
          -- logHook = dynamicLog $ logHook defaultConfig,
          -- logHook = dynamicLogDzen $ logHook defaultConfig	,
          -- logHook = dynamicLogWithPP $ xmobarPP
          --   {
          --      ppOutput = hPutStrLn xmproc,
          --      ppTitle = xmobarColor "green" "" . shorten 65,
          --  	}
          -- defaultGaps = [(15,0,0,0)],
          normalBorderColor = "#333333",
          focusedBorderColor = "#9999ff"
        }

