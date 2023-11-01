;;; unreal.el -*- lexical-binding: t; -*-
(ue-global-mode)
(map!
 :leader
 :map ue-mode-map
 :desc "Unreal"
 "U" 'ue-command-map)
