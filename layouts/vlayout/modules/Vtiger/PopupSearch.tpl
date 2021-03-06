{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is:  vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
* Contributor(s): YetiForce.com
********************************************************************************/
-->*}
{strip}
    <input type="hidden" id="parentModule" value="{$SOURCE_MODULE}"/>
    <input type="hidden" id="module" value="{$MODULE}"/>
    <input type="hidden" id="parent" value="{$PARENT_MODULE}"/>
    <input type="hidden" id="sourceRecord" value="{$SOURCE_RECORD}"/>
    <input type="hidden" id="sourceField" value="{$SOURCE_FIELD}"/>
    <input type="hidden" id="url" value="{$GETURL}" />
    <input type="hidden" id="multi_select" value="{$MULTI_SELECT}" />
    <input type="hidden" id="currencyId" value="{$CURRENCY_ID}" />
    <input type="hidden" id="relatedParentModule" value="{$RELATED_PARENT_MODULE}"/>
    <input type="hidden" id="relatedParentId" value="{$RELATED_PARENT_ID}"/>
    <input type="hidden" id="view" value="{$VIEW}"/>
    <input type="hidden" id="popupType" value="{$POPUPTYPE}"/>
    <div class="popupContainer row">
	{if $POPUPTYPE == 1}
        <div class="logo col-md-6"><img src="{$COMPANY_LOGO->get('imagepath')}" title="{$COMPANY_LOGO->get('title')}" alt="{$COMPANY_LOGO->get('alt')}" width="160px;"/></div>
        <div class="col-md-6"><strong>{vtranslate($MODULE_NAME, $MODULE_NAME)}</strong></div>
    </div>
    <div class="row form-inline">
	{/if}
		<div class="col-md-2 form-group">
			{if $MULTI_SELECT}
				{if !empty($LISTVIEW_ENTRIES)}<button class="select btn btn-default"><strong>{vtranslate('LBL_SELECT', $MODULE)}</strong></button>{/if}
			{else}
				&nbsp;
			{/if}
		</div>
        <div class="col-md-6 form-group pull-left">
			{if $POPUPTYPE == 2}
				<h3>{vtranslate($MODULE_NAME, $MODULE_NAME)}</h3>
			{/if}
            <form class="popupSearchContainer form-inline" onsubmit="return false;" method="POST">
			{if $POPUPTYPE == 1}
					<div class="form-group">
						<label class="sr-only" for="searchvalue">{vtranslate('LBL_TYPE_SEARCH')}</label>
						<input type="text" class="form-control" id="searchvalue" title="{vtranslate('LBL_TYPE_SEARCH')}" placeholder="{vtranslate('LBL_TYPE_SEARCH')}">
					</div>
					<span><strong>&nbsp;{vtranslate('LBL_IN')}&nbsp;</strong></span>
					<div class="form-group ">
						<label class="sr-only" for="searchableColumnsList">{vtranslate('LBL_SEARCH_IN_FIELD')}</label>
                        {assign var = defaultSearchField value = $RECORD_STRUCTURE_MODEL->getModule()->getDefaultSearchField()}
                        <select class="chzn-select form-control" id="searchableColumnsList" title="{vtranslate('LBL_SEARCH_IN_FIELD')}">
                            {foreach key=block item=fields from=$RECORD_STRUCTURE}
                                {foreach key=fieldName item=fieldObject from=$fields}
                                    <optgroup>
                                        <option value="{$fieldName}" {if $fieldName eq $defaultSearchField} selected {/if}>{vtranslate($fieldObject->get('label'),$MODULE_NAME)}</option>
                                    </optgroup>
                                {/foreach}
                            {/foreach}
                        </select>
					</div> 
						&nbsp;
					<div id="popupSearchButton" class=' form-group '>
                        <button class="btn btn-default"><span class="glyphicon glyphicon-search " title="{vtranslate('LBL_SEARCH_BUTTON')}"></span></button>
                    </div>
               
				
			{else if $POPUPTYPE == 2}
				<input class="col-md-2" type="hidden" id="searchfield"/>
				<input class="col-md-2" type="hidden" id="searchvalue"/>
			{/if}
            </form>
        </div>
		<div class="col-md-4 form-group pull-right">
			{if $SOURCE_MODULE neq 'PriceBooks' && $SOURCE_FIELD neq 'productsRelatedList'}
			<div class="popupPaging">
				<div class="row">
						<div class="col-md-12">
							<div class="pull-right">
								<div class="pageNumbers">
									<span class="pageNumbersText">{if !empty($LISTVIEW_ENTRIES)}{$PAGING_MODEL->getRecordStartRange()} {vtranslate('LBL_to', $MODULE)} {$PAGING_MODEL->getRecordEndRange()}{else}<span>&nbsp;</span>{/if}</span>
									<span class="alignBottom">
										<span class="glyphicon glyphicon-refresh totalNumberOfRecords cursorPointer{if empty($LISTVIEW_ENTRIES)} hide{/if}" style="margin-left:5px"></span>
									</span>
								</div>
								<div class="btn-group alignTop margin0px">
									<span class="pull-right">
										<span class="btn-group" role="group">
											<button class="btn btn-default" role="group" id="listViewPreviousPageButton" {if !$PAGING_MODEL->isPrevPageExists()} disabled {/if} type="button"><span class="glyphicon glyphicon-chevron-left"></span></button>
												<button class="btn btn-default dropdown-toggle" role="group" type="button" id="listViewPageJump" data-toggle="dropdown" {if $PAGE_COUNT eq 1} disabled {/if}>
													<span class="vtGlyph vticon-pageJump" title="{vtranslate('LBL_LISTVIEW_PAGE_JUMP',$moduleName)}"></span>
												</button>
												<ul class="listViewBasicAction dropdown-menu" id="listViewPageJumpDropDown">
													<li>
														<div>
															<div class="col-md-4 recentComments textAlignCenter pushUpandDown2per"><span>{vtranslate('LBL_PAGE',$moduleName)}</span></div>
															<div class="col-md-3 recentComments">
																<input type="text" id="pageToJump" class="listViewPagingInput textAlignCenter" title="{vtranslate('LBL_LISTVIEW_PAGE_JUMP')}" value="{$PAGE_NUMBER}"/>
															</div>
															<div class="col-md-2 recentComments textAlignCenter pushUpandDown2per">
																{vtranslate('LBL_OF',$moduleName)}
															</div>
															<div class="col-md-2 recentComments pushUpandDown2per textAlignCenter" id="totalPageCount">{$PAGE_COUNT}</div>
														</div>
													</li>
												</ul>
											<button class="btn btn-default" id="listViewNextPageButton" {if (!$PAGING_MODEL->isNextPageExists()) or ($PAGE_COUNT eq 1)} disabled {/if} type="button"><span class="glyphicon glyphicon-chevron-right"></span></button>
										</span>
									</span>	
								</div>
							</div>
						</div>
					</div>
				</div>
			{/if}
		</div>
    </div>
{/strip}
