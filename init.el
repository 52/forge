;;; init.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; Licensed under MIT License, or Apache Version 2.0, at your discretion.
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; Usage of this file is permitted solely under a sanctioned license.
;;
;;; Commentary:
;;
;;; Code:

(defconst forge--emacs-minimal-version 30
  "The minimum required major version of GNU Emacs.")

;; Require a GNU Emacs version of `forge--emacs-minimal-version' or newer.
(when (< emacs-major-version forge--emacs-minimal-version)
  (error "This configuration is compatible with GNU Emacs %d and newer; you have version %s"
         forge--emacs-minimal-version emacs-major-version))

(require '+editor)
(require '+theme)

(require '+evil)

;; init.el ends here
