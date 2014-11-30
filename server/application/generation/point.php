<?php

/**
 * Point: The most basic geometry type. All other geometries
 * are built out of Points.
 */
class Point
{
  public $coords = array(2);
  protected $geom_type = 'Point';

  /**
   * Constructor
   *
   * @param numeric $x The x coordinate (or longitude)
   * @param numeric $y The y coordinate (or latitude)
   * @param numeric $z The z coordinate (or altitude) - optional
   */
  public function __construct($x, $y) {
    // Basic validation on x and y
    if (!is_numeric($x) || !is_numeric($y)) {
      throw new Exception("Cannot construct Point. x and y should be numeric");
    }

    // Convert to floatval in case they are passed in as a string or integer etc.
    $x = floatval($x);
    $y = floatval($y);

    $this->coords = array($x, $y);

  }

  /**
   * Get X (longitude) coordinate
   *
   * @return float The X coordinate
   */
  public function x() {
    return $this->coords[0];
  }

  /**
   * Returns Y (latitude) coordinate
   *
   * @return float The Y coordinate
   */
  public function y() {
    return $this->coords[1];
  }

  public function asArray($assoc = FALSE) {
    return $this->coords;
  }

  public function distance($otherPoint) {
    $x2 = $otherPoint->x();
    $y2 = $otherPoint->y();

    return sqrt(pow(($this->x() - $x2), 2) + pow(($this->y()- $y2), 2));
  }

}

