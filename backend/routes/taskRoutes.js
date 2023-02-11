const taskController= require('../controllers/taskController');
const express=require('express');

const router= express.Router();
router.route('/').get(taskController.getTasks).post(taskController.createTask);

router.route('/:id').patch(taskController.updateTask).delete(taskController.deleteTask);

module.exports= router;