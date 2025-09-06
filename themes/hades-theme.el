;;; hades-theme.el -*- lexical-binding: t; -*-

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

(deftheme hades
  "A dark color scheme fitting for the king of the underworld.")

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
