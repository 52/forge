;;; +view.el -*- lexical-binding: t; -*-
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

(use-package frame
  :unless noninteractive
  :config
  ;; Number of lines above and below the point.
  (setq scroll-margin 10)

  ;; Avoid sudden recentering during navigation.
  ;; Large values (`101+') effectively disable this completely.
  (setq scroll-conservatively 101)

  ;; Enable faster scrolling through unfontified regions.
  ;; Improves performance at the cost of inaccurate highlights.
  (setq fast-but-imprecise-scrolling t)

  ;; Preserve the point's position when paging.
  (setq scroll-preserve-screen-position t)

  ;; Disable automatic per-line vertical scrolling.
  ;; Improves performance and resolves half-jumps when scrolling.
  (setq auto-window-vscroll nil)

  ;; Prevent the cursor from blinking.
  (setq blink-cursor-mode nil)

  ;; Surpress the default save messages.
  (setq save-silently t)

  ;; Load the `hades' theme after startup.
  (add-hook 'emacs-startup-hook (lambda () (load-theme 'hades t))))

(use-package minibuffer
  :unless noninteractive
  :config
  ;; Prefer single-key answers for `read-answer' prompts.
  (setq read-answer-short t)

  ;; Accept `y/n' instead of `yes/no' globally.
  (setq use-short-answers t)

  ;; Display active key-sequences in the minibuffer.
  ;; This is the equivalent of `showcmd' in vim.
  (setq echo-keystrokes 0.2)

  ;; Allow for recursive minibuffers during input.
  ;; This is needed by advanced commands and completion UIs.
  (setq enable-recursive-minibuffer t))

(use-package display-line-numbers
  :unless noninteractive
  :preface
  (defvar forge--display-line-number-hooks
    '(prog-mode-hook text-mode-hook conf-mode-hook)
    "List of major mode hooks where `display-line-numbers-mode' is enabled.")
  :config
  ;; Prefer relative line-numbers for overall navigation.
  ;; However keep the current line absolute (vim-like).
  (setq-default display-line-numbers 'relative)
  (setq-default display-line-numbers-type 'relative)
  (setq-default display-line-numbers-current-absolute t)

  ;; Reserve a fixed width for the line-number display.
  ;; This reduces the cost from computing the space dynamically.
  (setq-default display-line-numbers-width 3)

  ;; Enable `display-line-numbers-mode' in common editing modes.
  ;; This adds a hook for all items in `forge--display-line-number-hooks'.
  (dolist (hook forge--display-line-number-hooks)
    (add-hook hook #'display-line-numbers-mode)))

(use-package hl-line
  :unless noninteractive
  :preface
  (defvar forge--display-hl-line-hooks
    '(prog-mode-hook text-mode-hook conf-mode-hook)
    "List of major mode hooks where `hl-line-mode' is enabled.")
  :config
  ;; Only highlight the current line in the selected window.
  ;; This prevents non-selected windows from tracking their own point.
  (setq hl-line-sticky-flag nil)

  ;; Enable `hl-line-mode' in common editing modes.
  ;; This adds a hook for all items in `forge--display-hl-line-hooks'.
  (dolist (hook forge--display-hl-line-hooks)
    (add-hook hook #'hl-line-mode)))

(use-package paren
  :unless noninteractive
  :config
  ;; Reduce the delay before matching.
  (setq show-paren-delay 0.1)

  ;; Highlight the matching pair when point is inside.
  (setq show-paren-when-point-inside-paren t)

  ;; Highlight the matching pair when point is near.
  (setq show-paren-when-point-in-periphery t)

  ;; Prevent parantheses from blinking.
  (setq blink-matching-paren nil)

  ;; Enable `show-paren-mode' after initialization.
  (add-hook 'after-init-hook #'show-paren-mode))

(use-package smartparens
  :unless noninteractive
  :config
  ;; Load the upstream defaults for common languages.
  ;; See: https://github.com/fuco1/smartparens/blob/master/smartparens-config.el
  (require 'smartparens-config)

  ;; Disables `smartparens' overlays.
  ;; This is already handled by `show-parens'.
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil)

  ;; Limit prefix scanning to avoid performance hits.
  ;; This prevents slowdowns when scanning large expressions.
  (setq sp-max-prefix-length 25)

  ;; Enable `smartparens-global-mode' after initialization.
  (add-hook 'after-init-hook #'smartparens-global-mode))

(provide '+view)

;;; +view.el ends here
