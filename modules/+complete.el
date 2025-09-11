;;; +complete.el -*- lexical-binding: t; -*-
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

(use-package corfu
  :unless noninteractive
  :preface
  (defvar forge--corfu-disabled-modes
    '(vterm-mode eshell-mode help-mode org-mode)
    "List of modes where `global-corfu-mode' is disabled.")
  :config
  ;; Enable cycling through completion candidates.
  (setq corfu-cycle t)

  ;; Set the maximum number of candidates shown.
  (setq corfu-count 12)

  ;; Set the maximum width of the popup.
  (setq corfu-max-width 120)

  ;; Preselect the prompt rather than the candidate.
  (setq corfu-preselect 'prompt)

  ;; Keep the minibuffer free of Corfu.
  ;; This avoids conflicts with minibuffer-specific UIs.
  (setq global-corfu-minibuffer nil)

  ;; Set the specific modes where Corfu is enabled.
  ;; The modes defined in `forge--corfu-disabled-modes' are excluded.
  (setq global-corfu-modes `((not ,@forge--corfu-disabled-modes) t))

  ;; Kill Corfu when exiting `evil' insert state.
  ;; This prevents any popups from lingering in normal mode.
  (add-hook 'evil-insert-state-exit-hook #'corfu-quit)

  ;; Enable `global-corfu-mode' after initialization.
  (add-hook 'after-init-hook #'global-corfu-mode))

(use-package vertico
  :unless noninteractive
  :config
  ;; Enable cycling through completion candidates.
  (setq vertico-cycle t)

  ;; Set the maximum number of candidates shown.
  (setq vertico-count 10)

  ;; Prevent the Vertico UI from resizing dynamically.
  (setq vertico-resize nil)

  ;; Enable `vertico-mode' after initialization.
  (add-hook 'after-init-hook #'vertico-mode))

(provide '+complete)

;;; +complete.el ends here
