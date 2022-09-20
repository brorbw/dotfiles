;;; suez-mode.el -*- lexical-binding: t; -*-

(define-generic-mode 'suez-mode
  ()
  '("if" "is" "not" "in" "over" "day" "days" "minutes")
  '(
    ("authorization" . 'font-lock-warning-face)
    ("capture" . 'font-lock-warning-face)
    ("credit" . 'font-lock-warning-face)
    ("refund" . 'font-lock-warning-face)
    ("challenge" . 'font-lock-keyword-face)
    ("reject" . 'font-lock-keyword-face)
    ("balance" . 'font-lock-string-face)
    ("amount" . 'font-lock-const-face)
    ("merchant" . 'font-lock-variable-name-face)
    ("declined" . 'font-lock-variable-name-face)
    ("[0-9]*" . 'font-lock-variable-name-face)
    )
  nil
  nil
  "Major mode for SUEZ rules")
