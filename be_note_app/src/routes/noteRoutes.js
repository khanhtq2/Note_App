const express = require('express');
const router = express.Router();

const noteController = require('../controllers/noteControllers');
router.get('/search', noteController.searchNotes);
router.get('/get', noteController.getAllNotes);
router.post('/create', noteController.createNote);
router.put('/update/:id', noteController.updateNote);
router.delete('/delete/:id', noteController.deleteNote);

module.exports = router;