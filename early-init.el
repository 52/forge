;;; early-init.el -*- lexical-binding: t; -*-

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

(defvar forge--backup-gc-cons-threshold gc-cons-threshold
  "Backup of the original `gc-cons-threshold` value.")

(defvar forge--backup-gc-cons-percentage gc-cons-percentage
  "Backup of the original `gc-cons-percentage` value.")

(defvar forge--gc-cons-threshold (* 64 1024 1024)
  "Value to which `gc-cons-threshold' is set to post-startup.
This defines a moderate threshold (64 MB) for garbage collection.")

(defvar forge--gc-cons-percentage gc-cons-percentage
  "Value to which `gc-cons-percentage' is set to post-startup.
For now this maintains the default but can be adjusted if needed.")

(defun forge--restore-gc-values ()
  "Restore garbage collection thresholds after startup."
  (setq gc-cons-threshold forge--backup-gc-cons-threshold)
  (setq gc-cons-percentage forge--backup-gc-cons-percentage))

;; Temporarily increase thresholds to a maximum during startup.
;; This defers GC, and speeds up initialization by avoiding frequent
;; GC-induced pauses at the cost of temporarily higher memory usage.
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; Schedule the restoration of the original GC values after startup.
;; This ensures the original values, `forge--backup-gc-cons-threshold`
;; and `forge--gc-cons-percentage` are restored after startup.
(add-hook 'emacs-startup-hook #'forge--restore-gc-values)

;; Increase the maximum amount of data read from processes in a single chunk.
;; This increases the performance for subprocess-heavy operations like LSP's
;; by reducing the overhead encountered in data transfer.
(setq read-process-output-max (* 4 1024 1024))

;; Set the language environment to UTF-8 and disable the default input method.
;; This ensures consistent Unicode handling across GNU Emacs.
(set-language-environment "UTF-8")
(setq default-input-method nil)

;;; early-init.el ends here
