import React from "react";
import { Link } from "react-router-dom";
import Title from "./common/Title";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center bg-image">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <Title titleText = "Food Recipes"
               subtitleText = "A curated list of recipes for the best homemade meal and delicacies." />
        <hr className="my-4" />
        <div className="d-flex justify-content-center">
          <Link to="/recipes" className="btn btn-lg custom-button" role="button">
            View Recipes
          </Link>
        </div>
      </div>
    </div>
  </div>
);
