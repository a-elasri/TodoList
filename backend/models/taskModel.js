const mongoose= require('mongoose');

const taskSchema= mongoose.Schema({
name:{
    type: String,
    required:[true, 'A task Must have a name'],
    maxlength: [40, 'A task must have less or equal then 40 characters'],
    minlength: [3, 'A task must have more or equal then 10 characters'],
},

description:{
    type: String,
    required:[true, 'A task Must have a description'],
    minlength: [3, 'A task must have more or equal then 10 characters'],
},
terminated:{
    type: Boolean,
}

});
const Task= mongoose.model('Task', taskSchema);

module.exports= Task;