;;; init.el -*- lexical-binding: t; -*-

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

;;; Commentary:

;;; Code:

(defconst forge--emacs-minimal-version 30
  "The minimum required major version of GNU Emacs.")

;; Require a GNU Emacs version of `forge--emacs-minimal-version` or newer.
(when (< emacs-major-version forge--emacs-minimal-version)
  (error "This configuration is compatible with GNU Emacs %d and newer; you have version %s"
         forge--emacs-minimal-version emacs-major-version))

(defun forge--report-init-time ()
  "Report the total startup time and garbage collection statistics."
  (let* ((total (float-time (time-subtract (current-time) before-init-time)))
         (gcs (if (boundp 'gcs-done) gcs-done 0)))
    (message "Total startup time: %.3fs (%d GCs)" total gcs)))

;; Schedule the reporting of startup statistics after startup.
;; This will display the total startup time and the number of GC operations.
(add-hook 'emacs-startup-hook #'forge--report-init-time)

;; init.el ends here
