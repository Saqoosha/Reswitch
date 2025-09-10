// Toggle display resolution between 3840x2160 and 2560x1440.
// Comments in English per repo guidelines.

import CoreGraphics
import Foundation

let targetA = (w: 3840, h: 2160)
let targetB = (w: 2560, h: 1440)

func currentSize(of display: CGDirectDisplayID) -> (Int, Int) {
    let mode = CGDisplayCopyDisplayMode(display)!
    return (Int(mode.width), Int(mode.height))
}

func allModes(for display: CGDirectDisplayID) -> [CGDisplayMode] {
    let opts: CFDictionary = [kCGDisplayShowDuplicateLowResolutionModes: kCFBooleanTrue] as CFDictionary
    let arr = CGDisplayCopyAllDisplayModes(display, opts)! as [AnyObject]
    return arr as! [CGDisplayMode]
}

func pickMode(display: CGDirectDisplayID, width: Int, height: Int) -> CGDisplayMode {
    let modes = allModes(for: display)
        .filter { Int($0.width) == width && Int($0.height) == height }
        .sorted {
            if $0.pixelWidth != $1.pixelWidth {
                return $0.pixelWidth > $1.pixelWidth
            }
            return $0.refreshRate > $1.refreshRate
        }
    return modes.first!
}

// Always operate on main display (works for mirrored sets via master).
let display = CGMainDisplayID()

// Only toggle when current is exactly one of targets; otherwise do nothing.
let (cw, ch) = currentSize(of: display)
let nextOpt: (w: Int, h: Int)? =
    (cw == targetA.w && ch == targetA.h) ? targetB :
    (cw == targetB.w && ch == targetB.h) ? targetA : nil

if let next = nextOpt {
    let mode = pickMode(display: display, width: next.w, height: next.h)
    var config: CGDisplayConfigRef?
    CGBeginDisplayConfiguration(&config)
    CGConfigureDisplayWithDisplayMode(config, display, mode, nil)
    CGCompleteDisplayConfiguration(config, .permanently)
}
