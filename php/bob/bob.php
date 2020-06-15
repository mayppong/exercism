<?php

class Bob {
    function respondTo(string $input) {
        $input = trim($input);

        $response = 'Whatever.';
        if ($this->isQuestion($input)) {
            if ($this->isYelling($input)) {
                $response = 'Calm down, I know what I\'m doing!';
            }
            else {
                $response = 'Sure.';
            }
        }
        else if (trim($input) === '') {
            $response = 'Fine. Be that way!';
        }
        else if ($this->isYelling($input)) {
            $response = 'Whoa, chill out!';
        }

        return $response;
    }

    protected function isQuestion(string $input) {
        return strpos($input, '?') === (strlen($input) - 1);
    }

    protected function isYelling(string $input) {
        $string = trim(preg_replace('/[^a-zA-Z]/', '', $input));
        if ($string !== '') {
            return $string === strtoupper($string);
        }
        return false;
    }
}