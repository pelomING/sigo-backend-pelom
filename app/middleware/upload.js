const multer = require('multer');

// Set up storage for uploaded files
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const storageMemory = multer.memoryStorage();

// Create the multer instance
const upload = multer({ storage: storageMemory, fileFilter: ( req, file, cb) => {
    // Verificar tipo MIME del archivo
    if (file.mimetype === 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' || 
        file.mimetype === 'application/vnd.ms-excel') {
      cb(null, true);
    } else {
      cb(new Error('Tipo de archivo no permitido. Por favor, sube un archivo Excel.'));
    }
  } 
});

const uploadJs = {
  upload,
  storageMemory
}

module.exports = uploadJs