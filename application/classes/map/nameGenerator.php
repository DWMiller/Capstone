<?php 

class NameGenerator {
    private $minSyallables = 2;
    private $maxSyllables = 6;


// You need to generate random syllables. The simplest way to do it is to use syllables that are consonant-vowel, 
// or consonant-vowel-consonant. From a list of consonants and vowels, 
// pick randomly to build syllables, then join the syllables together to make a string.
// Keep in mind your list of consonants shouldn't be letters that are consonants, 
// but phonemes, so "th", "st", "sl", etc, 
// could be entries in the consonant list.


    // private $syllableLength = 3;
    private $syllables = array(
        'ber',
        'cebi',
        'di',
        'dit',
        'gez',
        'la',
        'lex',
        'min',
        'nas',
        'net',
        'qua',
        'ra',
        're',
        'ri',
        'ro',
        'se',
        'sla',
        'so',
        'ste',
        'tel',
        'tha',
        'the',        
        'vet',
        );

    public function __construct(){}   

    public function generate() {
        $string = '';

        $length = rand($this->minSyallables, $this->maxSyllables);
        $length = rand($this->minSyallables, $length); // more likely to be short

        for ($i=0; $i < $length; $i++) { 
            $string.=$this->getSyllable();
            $string.=$this->tryAddingSpace($i);
        }

        return $string;
    }

    private function getSyllable() {
        $key = array_rand($this->syllables);
        return $this->syllables[$key];
    }

    private function tryAddingSpace($syllabelleCount) {
        $rand = rand(0 + $syllabelleCount, 10);

        if ($rand > 6) { // closer to 10 for less likely spaces,
            return ' ';
        } 

        return '';
    }
}

 ?>
