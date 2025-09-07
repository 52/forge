;;; hades-theme.el -*- lexical-binding: t; -*-
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


(deftheme hades
  "A dark color scheme of the underworld.")

(let* ((class '((class color) (min-colors 256)))

       (background "#1c1c1c")
       (foreground "#e6e6e6"))

  (custom-theme-set-faces
   'hades
   `(default ((,class (:background ,background :foreground ,foreground))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'hades)
(provide 'hades-theme)

;; hades-theme.el ends here
