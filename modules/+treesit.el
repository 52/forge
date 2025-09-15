;;; +treesit.el -*- lexical-binding: t; -*-
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

(use-package treesit
  :unless noninteractive
  :preface
  (defvar forge--treesit-grammar-directory
    (concat-path forge-cache-directory "tree-sitter")
    "Directory where Tree-sitter files are stored in.")
  :config
  ;; This temporarily overrides `user-emacs-directory' to point to
  ;; `forge-cache-directory' so the `treesit' internals write the 
  ;; compiled `*.so' files to our cache instead.
  (let ((overwrite-directory-fn (lambda (orig-fn &rest args)
              (let ((user-emacs-directory forge-cache-directory))
                (apply orig-fn args)))))

  ;; Both functions rely on `user-emacs-directory' for determining where
  ;; to store the compiled grammar so we advise them to use our cache.
  (dolist (fn '(treesit-install-language-grammar treesit--build-grammar))
    (advice-add fn :around overwrite-directory-fn)))

  ;; Add the `forge--treesit-grammar-directory' to the `treesit' load path.
  ;; This ensures that Tree-sitter can find the compiled grammars.
  (add-to-list 'treesit-extra-load-path forge--treesit-grammar-directory))

(use-package treesit-auto
  :unless noninteractive
  :after treesit
  :config
  ;; Enable automatic installation of Tree-sitter grammars.
  ;; However - prompt for confirmation before doing so.
  (setq treesit-auto-install 'prompt)

  ;; Enable `global-treesit-auto-mode' after initialization.
  (add-hook 'after-init-hook #'global-treesit-auto-mode))

(provide '+treesit)

;;; +treesit.el ends here
