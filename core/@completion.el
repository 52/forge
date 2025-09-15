;;; @completion.el -*- lexical-binding: t; -*-
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

  ;; Set the minimum width of the popup.
  (setq corfu-min-width 30)

  ;; Set the maximum width of the popup.
  (setq corfu-max-width 60)

  ;; Do not pre-select any candidate initially.
  ;; This keeps the original input active instead of a candidate.
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

  ;; Hide commands in `M-x' which do not apply to the current mode.
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  ;; Bind `M-n' and `M-p' for cycling through candidates.
  ;; This overrides the default minibuffer history navigation.
  (define-key vertico-map (kbd "M-n") #'vertico-next)
  (define-key vertico-map (kbd "M-p") #'vertico-previous)

  ;; Bind `C-n' and `C-p' for cycling through the input history.
  ;; This restores the default minibuffer history navigation.
  (define-key vertico-map (kbd "C-n") #'next-history-element)
  (define-key vertico-map (kbd "C-p") #'previous-history-element)

  ;; Enable `vertico-mode' after initialization.
  (add-hook 'after-init-hook #'vertico-mode))

(use-package marginalia
  :unless noninteractive
  :config
  ;; Enable `marginalia-mode' after initialization.
  (add-hook 'after-init-hook #'marginalia-mode))

(use-package orderless
  :unless noninteractive
  :config
  ;; Set the default completion styles with `orderless' first.
  ;; This matches space-separated components and falls back to `basic'.
  (setq completion-styles '(orderless basic))

  ;; Reset the default completion category settings.
  ;; This removes built-in per-category defaults that might conflict.
  (setq completion-category-defaults nil)

  ;; Enable hybrid completion styles specifically for files.
  ;; This combines `orderless' matching with `partial-completion'.
  (setq completion-category-overrides '((file (styles orderless partial-completion))))

  ;; Enable space-separated component splitting with escapes.
  ;; This allows literal spaces to be escaped in matching patterns.
  (setq orderless-component-separator #'orderless-escapable-split-on-space))

(use-package consult
  :unless noninteractive
  :config
  ;; Reduce the minimum required input length.
  ;; This allows for requests to trigger with shorter queries.
  (setq consult-async-min-input 2)

  ;; Reduce the delay before polling for results.
  ;; This makes async commands update more frequently.
  (setq consult-async-refresh-delay 0.15)

  ;; Reduce the asynchronous input throttle delay.
  ;; This allows for requests to dispatch more frequently.
  (setq consult-async-input-throttle 0.2)

  ;; Reduce the asynchronous input throttle debounce.
  ;; This triggers new results sooner after typing pauses.
  (setq consult-async-input-debounce 0.1)
  
  ;; Remap built-in commands with their `consult' equivalent.
  ;; These remappings generally provide a superior editing experience.
  (define-key global-map [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
  (define-key global-map [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
  (define-key global-map [remap switch-to-buffer-other-tab] #'consult-buffer-other-tab)
  (define-key global-map [remap project-switch-to-buffer] #'consult-project-buffer)
  (define-key global-map [remap recentf-open-files] #'consult-recent-file)
  (define-key global-map [remap switch-to-buffer] #'consult-buffer)
  (define-key global-map [remap bookmark-jump] #'consult-bookmark)
  (define-key global-map [remap goto-line] #'consult-goto-line)

  ;; Additional bindings for `consult' commands.
  (define-key global-map (kbd "M-s r") #'consult-ripgrep)
  (define-key global-map (kbd "M-s f") #'consult-find)
  (define-key global-map (kbd "M-s l") #'consult-line))

(provide '@completion)

;;; @completion.el ends here
