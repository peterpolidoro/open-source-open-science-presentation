;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      ;; org-html-head "<link rel=\"stylesheet\" href=\"css/simple.css\" /> <link rel=\"stylesheet\" href=\"css/dark-mode.css\" />"
      org-html-head "<link rel=\"stylesheet\" href=\"css/terminal.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :base-directory "./content"
             :base-extension "org"
             :publishing-directory "./public"
             :recursive t
             :publishing-function 'org-html-publish-to-html
             :with-title nil
             :with-author nil
             :with-creator nil
             :with-toc nil
             :section-numbers nil
             :time-stamp-file nil)
       (list "org-static"
             :base-directory "./content"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
             :publishing-directory "./public"
             :recursive t
             :publishing-function 'org-publish-attachment)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
