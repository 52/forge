;;; init.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; SPDX-License-Identifier: MIT OR Apache-2.0
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; This project is dual-licensed under MIT License and Apache License 2.0.
;; You may use this file under either license at your discretion.
;;
;;; Commentary:
;;
;;; Code:

(defconst forge-modules
  '(+editor +view +complete +term +evil)
  "List of modules to load at startup.")

(when (not forge--nix)
  ;; Initialize and refresh `package.el' on non-Nix systems.
  ;; Since we disabled the automatic package initialization,
  ;; we need to explicitly bootstrap the package process.
  (require 'package)

  ;; Initialize only once - if not already done.
  (unless (bound-and-true-p package--initialized)
    (package-initialize))

  (unless (package-installed-p 'use-package)
    ;; Refresh only when the archive cache is empty.
    (when (not package-archive-contents)
      (package-refresh-contents))

    ;; Ensure that `use-package` is installed.
    (package-install 'use-package))

  (require 'use-package))

;; Require all `forge-modules' in sequence.
;; Files must contain a matching `provide' statement for resolution.
(mapc #'require forge-modules)

;;; init.el ends here
