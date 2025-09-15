;;; early-init.el -*- lexical-binding: t; -*-
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

(defconst emacs-minimal-version 30
  "The minimum required major version of GNU Emacs.")

;; Require a GNU Emacs version of >= `emacs-minimal-version'.
(when (< emacs-major-version emacs-minimal-version)
  (error "This configuration requires minimum GNU Emacs %d; you have version %d"
         emacs-minimal-version emacs-major-version))

;; Alias `file-name-concat' -> `concat-path'.
(defalias 'concat-path #'file-name-concat)

(defvar forge-state-directory
  (concat-path (or (getenv "XDG_STATE_HOME") "~/.local/state") "forge")
  "The directory for storing persistent state data.
Follows the XDG Base Directory specification for state files.
See: https://specifications.freedesktop.org/basedir-spec/latest")

(defvar forge-data-directory
  (concat-path (or (getenv "XDG_DATA_HOME") "~/.local/share") "forge")
  "The directory for storing application data files.
Follows the XDG Base Directory specification for data files.
See: https://specifications.freedesktop.org/basedir-spec/latest")

(defvar forge-cache-directory
  (concat-path (or (getenv "XDG_CACHE_HOME") "~/.cache") "forge")
  "The directory for storing temporary cache files.
Follows the XDG Base Directory specification for cache files.
See: https://specifications.freedesktop.org/basedir-spec/latest")

(defvar forge--nix (equal (getenv "NIX") "1")
  "Non-nil when `NIX' is set in the environment.")

(defvar forge--debug (equal (getenv "DEBUG") "1")
  "Non-nil when `DEBUG' is set in the environment.")

(defvar forge--gc-cons-threshold (* 16 1024 1024)
  "Value to which `gc-cons-threshold' is set to post-startup.
This defines a moderate threshold (16 MB) for garbage collection.")

(defvar forge--gc-cons-percentage gc-cons-percentage
  "Value to which `gc-cons-percentage' is set to post-startup.
For now this maintains the default but can be adjusted if needed.")

(defun forge--gc-restore-values ()
  "Restore garbage collection thresholds after startup."
  (setq gc-cons-threshold forge--gc-cons-threshold)
  (setq gc-cons-percentage forge--gc-cons-percentage))

;; Temporarily increase thresholds to a maximum during startup.
;; This defers GC and speeds up initialization by avoiding frequent
;; halts at the cost of temporarily higher memory usage.
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; Schedule the restoration of the original GC values after startup.
;; This ensures the original values `forge--gc-cons-threshold' and
;; `forge--gc-cons-percentage' are restored after startup.
(add-hook 'emacs-startup-hook #'forge--gc-restore-values)

;; Increase the maximum amount of data read from processes in a single chunk.
;; This increases the performance for subprocess-heavy operations like LSPs
;; by reducing the overhead encountered in data transfer.
(setq read-process-output-max (* 4 1024 1024))

;; Prefer newer source files over older compiled artifacts.
;; This helps avoid loading stale `*.elc' and `*.eln' files.
(setq load-prefer-newer t)

;; Keep customization changes out of `init.el' by writing them to `custom.el'.
(setq custom-file (concat-path user-emacs-directory "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Set the `custom-theme-directory' to our `themes' folder.
(setq custom-theme-directory (concat-path user-emacs-directory "themes"))

;; Prepend the `core' folder to the `load-path'.
(add-to-list 'load-path (concat-path user-emacs-directory "core"))

;; Prepend the `langs' folder to the `load-path'.
(add-to-list 'load-path (concat-path user-emacs-directory "langs"))

(when forge--debug
  ;; Enable verbose debug prints.
  (setq init-file-debug t)

  ;; Halts execution and enters the debugger on error.
  (setq debug-on-error t))

(when (boundp 'native-comp-eln-load-path)
  ;; Redirect `*.eln' artifacts to "`forge-cache-directory'/eln-cache".
  (let* ((eln-cache (concat-path forge-cache-directory "eln-cache")))
    (setq native-compile-target-directory eln-cache)
    (startup-redirect-eln-cache eln-cache))

  ;; Ask the user before terminating compilations on exit.
  (setq native-comp-async-query-on-exit t)

  ;; Display native-compilation warnings only when `DEBUG=1'.
  (setq native-comp-async-report-warnings-errors forge--debug)
  (setq native-comp-warning-on-missing-source forge--debug))

;; Reduce the `pgtk-wait-for-event-timeout' for PGTK builds.
;; This improves responsiveness of child frames and packages.
(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

;; Set the language environment to UTF-8 and disable the default input method.
;; This ensures consistent Unicode handling across GNU Emacs.
(set-language-environment "UTF-8")
(setq default-input-method nil)

(when (not noninteractive)
  ;; Prevent GNU Emacs from resizing itself in steps.
  (setq frame-resize-pixelwise t)

  ;; Prevent GNU Emacs from implicit frame resizing.
  (setq frame-inhibit-implied-resize t)

  ;; Prevent GNU Emacs from resizing pixelwise.
  (setq window-resize-pixelwise nil)

  ;; Font compacting which can be very expensive, especially on Windows.
  ;; This disables it permanently, at the cost of higher memory usage.
  (setq inhibit-compacting-font-caches t)

  ;; Prevent unnecessary renders in non-selected windows.
  (setq-default cursor-in-non-selected-windows nil)
  (setq highlight-nonselected-windows nil)

  ;; Enable more performant scrolling over unfontified regions.
  ;; This may cause inaccurate syntax highlighting after scrolling.
  (setq fast-but-imprecise-scrolling t)

  ;; Inhibit an unnecessary pass over `auto-mode-alist'.
  (setq auto-mode-case-fold nil)

  ;; Disable the vanilla splash screen to streamline startup.
  (setq inhibit-startup-screen t)

  ;; Suppress the vanilla startup screen completely.
  ;; Without this the screen would still initialize.
  (advice-add #'display-startup-screen :override #'ignore)

  ;; Suppress the "For information about GNU Emacs..." message.
  (setq inhibit-startup-echo-area-message user-login-name)

  ;; Remove the "For information about GNU Emacs..." line in *Messages*.
  (advice-add #'display-startup-echo-area-message :override #'ignore)

  ;; Initialize the scratch buffer in `fundamental-mode'.
  (setq initial-major-mode 'fundamental-mode)

  ;; Start with an empty `*scratch*' buffer.
  (setq initial-scratch-message nil))

;; Hide the menu bar from the very first frame.
;; Toggle back with `M-x menu-bar-mode'.
(push '(menu-bar-lines . 0) default-frame-alist)
(setq menu-bar-mode nil)

;; Hide the tool bar from the very first frame.
;; Toggle back with `M-x tool-bar-mode'.
(push '(tool-bar-lines . 0) default-frame-alist)
(setq tool-bar-mode nil)

;; Hide the scroll bars from the very first frame.
;; Toggle back with `M-x scroll-bar-mode'.
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

;; Defer loading `package.el' until the `init.el' loads.
;; We explicitly bootstrap this later.
(setq package-enable-at-startup nil)

;; Enable verbose `use-package' logs when `DEBUG=1'.
(setq use-package-verbose forge--debug)

;; Automatically install packages missing from the system.
;; Disabled in Nix environments where packages are managed externally.
(setq use-package-always-ensure (not forge--nix))

;;; early-init.el ends here
