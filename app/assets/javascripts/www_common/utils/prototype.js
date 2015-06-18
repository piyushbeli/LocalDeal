/**
 Helper for formatting the string.
 "My name is {name} andc college name is {collegeName}".format({name: 'Piyush', college: 'NIT, Surat'}) will produce
 My name is Piyush and college name is NIT,Surat
 */
String.prototype.format = function() {
    var str = this.toString();
    if (!arguments.length)
        return str;
    var args = typeof arguments[0],
        args = (("string" == args || "number" == args) ? arguments : arguments[0]);
    for (arg in args)
        str = str.replace(RegExp("\\{" + arg + "\\}", "gi"), args[arg]);
    return str;
};

Array.prototype.notEmpty = function() {
    return this != null && this != undefined && this.length > 0;
};

Array.prototype.delete = function(id) {
    var i = -1;
    for (i =0; i < this.length; i++) {
        if (this[i].id == id) {
            break;
        }
    }
    if (i >= 0) {
        return this.splice(i,1);
    } else {
        return null;
    }

}

Date.prototype.isBefore = function(date) {
    return moment(this).isBefore(date);
}
Date.prototype.isAfter = function(date) {
    return moment(this).isAfter(date);
}
Date.prototype.isSame = function(date) {
    return moment(this).isSame(date);
};

Array.prototype.find = function(inputItem) {
    if (!inputItem) {
        return;
    }
    if (angular.isArray(inputItem)) {
        var result = [];
        for(var i=0; i<inputItem.length; i++) {
            this.forEach(function(item) {
                if ((item.id && item.id == inputItem[i].id) || (item.slug && item.slug == inputItem[i].slug)) {
                    result.push(item);
                }
            })
        }
        return result;
    } else {
        for (var i=0; i< this.length; i++) {
            if ((this[i].id && this[i].id == inputItem.id) || (this[i].slug && this[i].slug == inputItem.slug)) {
                return this[i];
            }
        }
    }
};

Array.prototype.findAll = function(inputItems) {
    return this.find(inputItems);
};

Array.prototype.remove = function(inputItem) {
    var index = -1;
    var self = this;
    this.forEach(function(item) {
        index++;
        if ((item.id && item.id == inputItem[i].id) || (item.slug && item.slug == inputItem[i].slug)) {
            self.splice(index,1);
            return;
        }
    })
};

Array.prototype.contains = function(item) {
    return this.find(item) != null;
}