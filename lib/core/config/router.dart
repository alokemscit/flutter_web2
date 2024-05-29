import 'package:agmc/core/config/const.dart';
import 'package:agmc/moduls/diet_management/diet_menu_config/pages/diet_menu_config.dart';
import 'package:agmc/moduls/finance/balance_sheet_page/fin_balancesheet_page.dart';
import 'package:agmc/moduls/finance/cost_center_linkage_page/cost_center_linkage.dart';
import 'package:agmc/moduls/finance/cost_center_page/cost_center_page.dart';
import 'package:agmc/moduls/finance/sub_ledger_linkage_page/sub_ledger_linkage_page.dart';

import 'package:agmc/moduls/finance/sub_ledger_master/sub_ledger_master_page.dart';
import 'package:agmc/moduls/finance/trail_balance_page/trail_balance.dart';

import 'package:agmc/moduls/finance/voucher_entry_page/voucher_entry_page.dart';
import 'package:agmc/moduls/pms_fnb/goods_formula_setup/pages/goods_formula_setup.dart';

import '../../moduls/diet_management/diet_category/pages/diet_category_page.dart';
import '../../moduls/diet_management/diet_meal_ietm/pages/diet_item_page.dart';
 
import '../../moduls/diet_management/diet_mealplan/pages/weekly_meal_plan.dart';
import '../../moduls/finance/fin_dashboard/fin_datshboadr.dart';
import '../../moduls/finance/fin_default_setup/fin_default_setup_page.dart';
import '../../moduls/finance/gl_opening_page/gl_opening_balance.dart';
import '../../moduls/finance/ledger_master_page/ledger_master_page.dart';
import '../../moduls/pms_fnb/plan_approval/pages/plan_approval_page.dart';
import '../../moduls/pms_fnb/pms_reports/pages/pms_report_page.dart';
import '../../moduls/pms_fnb/production_plan/pages/production_plan_page.dart';
import '../../moduls/pms_fnb/production_process/pages/production_process.dart';
import '../../moduls/pms_fnb/row_material_analyser/pages/material_needs_analysis.dart';

Widget getPage(String id) {
  switch (id) {
    case "212":
      {
        return const LedgerMasterPage();
      }
    case "208":
      {
        return const LedgerMasterPage();
      }
    case "206":
      {
        return const SubLedgerMaster();
      }
    case "207":
      {
        return const ConstcenterPage();
      }
    case "209":
      {
        return const SubLeaderLinkageMaster();
      }
    case "211":
      {
        return const VoucherEntryPage();
      }
    case "214":
      {
        return const GlOpeningBalance();
      }
    case "218":
      {
        return const TrailBalance();
      }

    case "1289":
      {
        return const CostCeneterLinkagePage();
      }

    case "1291":
      {
        return const FinDefaultPageSetup();
      }
    case "1300":
      {
        return const BalanceSgeetPage();
      }

// for diet ###########################
    case '1315':
      return const DietCategory();
    case '1316':
      return const DietItems();
    case '1317':
      return const WeeklyMealPlan(); // MealPlan();
    case '1318':
      return const DietMenuConfig();
//###########################

    // for pms fnb
    case "1305":
      {
        return const GoodsFormulaSetup();
      }
    case "1306":
      {
        return const ProductionPlan();
      }

    case "1307":
      {
        return const PlanApproval();
      }

    case "1308":
      {
        return const MaterialNeedsAnalysis();
      }
    case "1309":
      {
        return const ProductionProcess();
      }
    case "1310":
      {
        return const PmsReportsPage();
      }
//
    case "":
      return const SizedBox(
          //child: Text("Under Construction!"),
          );
    default:
      return const Center(
        child: Text(
          "Under Construction!",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
      );
  }
}

Widget getDashBoard(String id) {
  switch (id) {
    case "198":
      {
        return const FinDashBoard();
      }

    default:
      return const Center();
  }
}
