/*******************************************************************************
* KindEditor 预览
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence LGPL(http://www.opensource.org/licenses/lgpl-license.php)
* @version 1.0
*******************************************************************************/

KE.lang.selectwall = '选择墙面';

KE.plugin.selectwall = {
    click : function(id) {
        var dialog = new KE.dialog({
            id : id,
            cmd : 'selectwall',
            html : KE.util.getData(id),
            width : 600,
            height : 400,
            useFrameCSS : true,
            title : KE.lang['selectwall'],
            noButton : KE.lang['close']
        });
        dialog.show();
    }
};
