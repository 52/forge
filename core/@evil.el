;;; @evil.el -*- lexical-binding: t; -*-
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

(use-package evil
  :preface
  (defun forge--evil-adjust-scroll-margin ()
    "Adjust the `scroll-margin' near end-of-buffer.
This prevents extra lines at EOB when the point is within that distance."
    (unless (or (minibufferp) (window-minibuffer-p))
      (let* ((n (default-value 'scroll-margin))
             (new (if (and (> n 0) (save-excursion (forward-line n) (eobp))) 0 n)))
        (unless (eq scroll-margin new)
          (setq-local scroll-margin new)))))

  (defun forge--evil-adjust-shift-width ()
    "Adjust `evil-shift-width' to mirror `tab-width'.
This keeps the indentation operators (>> and <<) aligned across major modes."
    (unless (derived-mode-p 'org-mode)
      (setq-local evil-shift-width tab-width)))

  (defun forge--evil-display-save-message ()
    "Display save confirmation with file statistics.
This shows the file name, line count, and character count after saving."
    (message "%s %dL %dC written"
             (or (file-relative-name buffer-file-name) (buffer-name))
             (count-lines (point-min) (point-max))
             (buffer-size)))
  :init
  ;; Prefer `undo-fu' as the default undo-backend.
  (setq evil-undo-system 'undo-fu)

  ;; Prefer a uniform cursor shape across motions.
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  :config
  ;; Adjust `scroll-margin' near end-of-buffer.
  (add-hook 'post-command-hook #'forge--evil-adjust-scroll-margin)

  ;; Keep `evil-shift-width' consistent with `tab-width'.
  (add-hook 'after-change-major-mode-hook #'forge--evil-adjust-shift-width)

  ;; Display `forge--evil-display-save-message' after saving.
  (add-hook 'after-save-hook #'forge--evil-display-save-message)

  ;; Enable `evil-mode' after initialization.
  (add-hook 'after-init-hook #'evil-mode))

(provide '@evil)

;;; @evil.el ends here
