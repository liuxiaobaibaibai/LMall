
require('lwPersonalVC,UITableView,NSArray,NSIndexPath,UINavigationController')

defineClass("lwPersonalVC", {
    collectionView_didSelectItemAtIndexPath: function(collectionView, indexPath) {
        var cell = (lwPeronalCell * ) collectionView.cellForItemAtIndexPath(indexPath);
        if (cell.titleLabel().text().isEqualToString("我的钱包")) {
            var wallet = lwWalletVC.alloc().init();
            wallet.setTitle("我的钱包");
            wallet.setHidesBottomBarWhenPushed(YES);
            self.navigationController().pushViewController_animated(wallet, YES);
        }
    },
})

defineClass('lwResultVC : UIViewController',{
   viewDidLoad: function() {
        self.ORIGviewDidLoad();
            genView()
   },
   genView: function() {
        var ciew = UIView.alloc().init();
        ciew.setFrame(CGRectMake(0, 0, lW, lH));
        ciew.setBackgroundColor(UIColor.redColor());
        self.view().addSubview(ciew);
   },
})

/** tableviewController*/
defineClass('JPTableViewController : UITableViewController <UIAlertViewDelegate>', {
    dataSource: function() {
        var data = self.getProp('data')
        if (data) return data;
        var data = [];
        for (var i = 0; i < 20; i ++) {
            data.push("cell from js " + i);
    }
    self.setProp_forKey(data, 'data')
        return data;
    },
    numberOfSectionsInTableView: function(tableView) {
        return 1;
    },
    tableView_numberOfRowsInSection: function(tableView, section) {
        return self.dataSource().count();
    },
    tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if (!cell) {
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
        }
        cell.textLabel().setText(self.dataSource().objectAtIndex(indexPath.row()))
        return cell
    },
    tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
        return 50
    },
    tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
        // self.navigationController().popToRootViewControllerAnimated(YES)
        tableView.deselectRowAtIndexPath_animated(indexPath, YES);
        require('UIAlertView');
        var alert = UIAlertView.alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("提示", self.dataSource().objectAtIndex(indexPath.row()), self, "确定", "取消", null);
        alert.show();
    },
})