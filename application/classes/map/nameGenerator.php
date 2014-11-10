<?php 

class NameGenerator {
    private $minSyallables = 2;
    private $maxSyllables = 5;

    private $syllableLength = 3;
    private $syllables ="lexegezacebisousesarmaindireaeratenberalavetiedorquanteisrion";

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
        $start = rand(1, strlen($this->syllables)-3);
        return substr($this->syllables, $start, $this->syllableLength);
    }

    private function tryAddingSpace($syllabelleCount) {
        $rand = rand(0 + $syllabelleCount, 10);

        if ($rand > 5) {
            return ' ';
        } 

        return '';
    }
}

 ?>
