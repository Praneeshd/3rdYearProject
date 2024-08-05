const cloudinary = require("cloudinary");
const Restaurants = require("../model/restaurantModel");

const createRestaurant = async (req, res) => {
    // Step 1: Check incoming data
    console.log(req.body);
    console.log(req.files);

    // Step 2: Destructuring data
    const {
        restaurantName,
        restaurantLocation,
        restaurantRating,
        restaurantReview,
        restaurantContact,
    } = req.body;
    const { restaurantImage } = req.files;

    // Step 3: Validate data
    if (!restaurantName || !restaurantLocation || !restaurantContact || !restaurantImage) {
        return res.json({
            success: false,
            message: "Please fill all the required fields",
        });
    }

    try {
        // Upload image to cloudinary
        const uploadedRestaurant = await cloudinary.v2.uploader.upload(
            restaurantImage.path,
            {
                folder: "restaurants",
                crop: "scale",
            }
        );

        // Save to database
        const newRestaurant = new Restaurants({
            restaurantName,
            restaurantLocation,
            restaurantRating,
            restaurantReview,
            restaurantContact,
            restaurantImageUrl: uploadedRestaurant.secure_url,
        });

        await newRestaurant.save();
        res.json({
            success: true,
            message: "Restaurant created successfully",
            restaurant: newRestaurant,
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false,
            message: "Internal server error",
        });
    }
};

// Get all restaurants
const getRestaurants = async (req, res) => {
    try {
        const allRestaurants = await Restaurants.find({});
        res.json({
            success: true,
            message: "All restaurants fetched successfully!",
            restaurants: allRestaurants,
        });
    } catch (error) {
        console.log(error);
        res.send("Internal server error");
    }
};

// Fetch single restaurant
const getSingleRestaurant = async (req, res) => {
    const restaurantId = req.params.id;
    try {
        const singleRestaurant = await Restaurants.findById(restaurantId);
        res.json({
            success: true,
            message: "Single restaurant fetched successfully!",
            restaurant: singleRestaurant,
        });
    } catch (error) {
        console.log(error);
        res.send("Internal server error");
    }
};

// Update restaurant
const updateRestaurant = async (req, res) => {
    // Step 1: Check incoming data
    console.log(req.body);
    console.log(req.files);

    // Destructuring data
    const {
        restaurantName,
        restaurantLocation,
        restaurantRating,
        restaurantReview,
        restaurantContact,
    } = req.body;
    const { restaurantImage } = req.files;

    // Validate data
    if (!restaurantName || !restaurantLocation || !restaurantContact || !restaurantImage) {
        return res.json({
            success: false,
            message: "Required fields are missing!",
        });
    }

    try {
        // Case 1: If there is an image
        if (restaurantImage) {
            // Upload image to cloudinary
            const uploadedImage = await cloudinary.v2.uploader.upload(
                restaurantImage.path,
                {
                    folder: "restaurants",
                    crop: "scale",
                }
            );

            // Make updated JSON data
            const updatedData = {
                restaurantName,
                restaurantLocation,
                restaurantRating,
                restaurantReview,
                restaurantContact,
                restaurantImageUrl: uploadedImage.secure_url,
            };

            // Find restaurant and update
            const restaurantId = req.params.id;
            await Restaurants.findByIdAndUpdate(restaurantId, updatedData);
            res.json({
                success: true,
                message: "Restaurant updated successfully with Image!",
                updatedRestaurant: updatedData,
            });
        } else {
            // Update without image
            const updatedData = {
                restaurantName,
                restaurantLocation,
                restaurantRating,
                restaurantReview,
                restaurantContact,
            };

            // Find restaurant and update
            const restaurantId = req.params.id;
            await Restaurants.findByIdAndUpdate(restaurantId, updatedData);
            res.json({
                success: true,
                message: "Restaurant updated successfully without Image!",
                updatedRestaurant: updatedData,
            });
        }
    } catch (error) {
        res.status(500).json({
            success: false,
            message: "Internal server error",
        });
    }
};

// Delete restaurant
const deleteRestaurant = async (req, res) => {
    const restaurantId = req.params.id;

    try {
        await Restaurants.findByIdAndDelete(restaurantId);
        res.json({
            success: true,
            message: "Restaurant deleted successfully!",
        });
    } catch (error) {
        res.json({
            success: false,
            message: "Server error!!",
        });
    }
};

module.exports = {
    createRestaurant,
    getRestaurants,
    getSingleRestaurant,
    updateRestaurant,
    deleteRestaurant,
};
