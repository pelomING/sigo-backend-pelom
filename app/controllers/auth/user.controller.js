const db = require("../../models");
const User = db.user;

exports.allAccess = (req, res) => {
    res.status(200).send("Public Content.");
  };
  
  exports.userBoard = (req, res) => {
    res.status(200).send("User Content.");
  };
  
  exports.adminBoard = (req, res) => {
    res.status(200).send("Admin Content.");
  };
  
  exports.moderatorBoard = (req, res) => {
    res.status(200).send("Moderator Content.");
  };

  /**
   * Retrieves a user by their ID.
   *
   * @param {Object} req - The request object.
   * @param {Object} res - The response object.
   * @returns {Object} The user object.
   */
  exports.getUser = async (req, res) => {
    try {
      const userId = req.params.id; // El ID del usuario se pasa a través de los parámetros de la ruta
      const user = await User.findByPk(userId);
  
      if (!user) {
        return res.status(404).send({ message: 'Usuario no encontrado' });
      }
  
      res.status(200).json(user);
    } catch (error) {
      return res.status(500).send({ message: error.message });
    }
  };
  
